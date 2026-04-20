from flask import Flask, request, jsonify
import joblib
import json
import pandas as pd
import os

app = Flask(__name__)

# Development:
#   Relative paths usually work when launching from AI_Model folder.
# Production (cPanel/Passenger):
#   Use absolute paths from this file to avoid path issues.
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_DIR = os.path.join(BASE_DIR, "model")

# Load model and encoders
model = joblib.load(os.path.join(MODEL_DIR, "crop_model.pkl"))
le_soil = joblib.load(os.path.join(MODEL_DIR, "le_soil.pkl"))
le_season = joblib.load(os.path.join(MODEL_DIR, "le_season.pkl"))
le_crop = joblib.load(os.path.join(MODEL_DIR, "le_crop.pkl"))

with open(os.path.join(MODEL_DIR, "mappings.json"), encoding="utf-8") as f:
    mappings = json.load(f)

FEATURES = mappings.get(
    "features",
    ["soil_moisture", "temperature", "humidity", "soil_type_enc", "season_enc"],
)

# Crop info lookup (water needs, yield, growth days)
CROP_INFO = {
    "wheat": {"water": "Medium", "yield": 2800, "days": 120},
    "rice": {"water": "High", "yield": 3500, "days": 150},
    "cotton": {"water": "Low", "yield": 1200, "days": 180},
    "maize": {"water": "Medium", "yield": 3000, "days": 90},
    "sugarcane": {"water": "High", "yield": 50000, "days": 365},
    "mustard": {"water": "Low", "yield": 1000, "days": 110},
    "chickpea": {"water": "Low", "yield": 900, "days": 100},
    "sunflower": {"water": "Medium", "yield": 1500, "days": 100},
}


@app.route("/health", methods=["GET"])
def health():
    return jsonify(
        {
            "status": "ok",
            "model_accuracy": f"{mappings['accuracy']}%",
            "crops_supported": mappings["crops"],
        }
    )


def build_features(soil_moisture, temperature, humidity, soil_enc, season_enc):
    row = {
        "soil_moisture": soil_moisture,
        "temperature": temperature,
        "humidity": humidity,
        "soil_type_enc": soil_enc,
        "season_enc": season_enc,
    }
    return pd.DataFrame([row])[FEATURES]


@app.route("/predict", methods=["POST"])
def predict():
    try:
        data = request.get_json(silent=True) or {}

        # Required fields
        soil_moisture = float(data["soil_moisture"])
        temperature = float(data["temperature"])
        humidity = float(data["humidity"])
        soil_type = str(data["soil_type"]).lower()
        season = str(data["season"]).lower()

        # Validate soil_type and season
        if soil_type not in le_soil.classes_:
            return (
                jsonify(
                    {
                        "success": False,
                        "message": f"Invalid soil_type. Valid: {list(le_soil.classes_)}",
                    }
                ),
                400,
            )

        if season not in le_season.classes_:
            return (
                jsonify(
                    {
                        "success": False,
                        "message": f"Invalid season. Valid: {list(le_season.classes_)}",
                    }
                ),
                400,
            )

        # Encode categorical inputs
        soil_enc = le_soil.transform([soil_type])[0]
        season_enc = le_season.transform([season])[0]

        # Predict
        features = build_features(soil_moisture, temperature, humidity, soil_enc, season_enc)
        prediction = model.predict(features)[0]
        proba = model.predict_proba(features)[0]
        crop = le_crop.inverse_transform([prediction])[0]
        confidence = round(float(max(proba)) * 100, 2)

        # Top alternatives (excluding primary)
        sorted_idx = proba.argsort()[::-1]
        alt_indices = sorted_idx[1:4]
        alt_crops = []
        for idx in alt_indices:
            alt_crop = le_crop.inverse_transform([int(idx)])[0]
            alt_conf = round(float(proba[idx]) * 100, 2)
            if alt_conf > 0:
                alt_crops.append(f"{alt_crop.title()} ({alt_conf}%)")

        # Recommendation text
        info = CROP_INFO.get(crop, {})
        reason = (
            f"Based on soil moisture ({soil_moisture}%), temperature ({temperature}C), "
            f"humidity ({humidity}%), {soil_type} soil, and {season.title()} season conditions, "
            f"{crop.title()} is the most optimal crop."
        )

        if alt_crops:
            reason += "\n\nAlternative options for this season:\n- " + "\n- ".join(alt_crops)

        # What-if insights
        features_hot = build_features(soil_moisture, temperature + 4, humidity, soil_enc, season_enc)
        features_cold = build_features(soil_moisture, temperature - 4, humidity, soil_enc, season_enc)
        features_wet = build_features(soil_moisture + 15, temperature, humidity, soil_enc, season_enc)

        crop_hot = le_crop.inverse_transform([model.predict(features_hot)[0]])[0]
        crop_cold = le_crop.inverse_transform([model.predict(features_cold)[0]])[0]
        crop_wet = le_crop.inverse_transform([model.predict(features_wet)[0]])[0]

        what_ifs = []
        if crop_hot != crop:
            what_ifs.append(f"If temp was +4C hotter, {crop_hot.title()} would be recommended.")
        if crop_cold != crop:
            what_ifs.append(f"If temp was -4C cooler, {crop_cold.title()} would be recommended.")
        if len(what_ifs) < 2 and crop_wet != crop:
            what_ifs.append(f"If soil moisture was +15% higher, {crop_wet.title()} would be recommended.")

        if what_ifs:
            reason += "\n\nEnvironmental alerts:\n" + "\n".join(what_ifs)

        return jsonify(
            {
                "success": True,
                "recommended_crop": crop,
                "confidence_score": confidence,
                "alternatives": alt_crops,
                "water_requirement": info.get("water", "Medium"),
                "expected_yield": info.get("yield", 0),
                "growth_duration_days": info.get("days", 0),
                "recommendation_reason": reason,
                "model_version": "1.0.1",
                "inputs": {
                    "soil_moisture": soil_moisture,
                    "temperature": temperature,
                    "humidity": humidity,
                    "soil_type": soil_type,
                    "season": season,
                },
            }
        )

    except KeyError as e:
        return jsonify({"success": False, "message": f"Missing field: {e}"}), 400
    except ValueError as e:
        return jsonify({"success": False, "message": f"Invalid numeric input: {e}"}), 400
    except Exception as e:
        return jsonify({"success": False, "message": str(e)}), 500


@app.route("/crops", methods=["GET"])
def get_crops():
    return jsonify(
        {
            "success": True,
            "crops": mappings["crops"],
            "soil_types": mappings["soil_types"],
            "seasons": mappings["seasons"],
        }
    )


if __name__ == "__main__":
    # Development (current):
    #   HOST=0.0.0.0, PORT=5001, FLASK_DEBUG=1
    # Production (cPanel):
    #   HOST=0.0.0.0, PORT assigned by app, FLASK_DEBUG=0
    host = os.getenv("HOST", "0.0.0.0")
    port = int(os.getenv("PORT", "5001"))
    debug_mode = os.getenv("FLASK_DEBUG", "1") == "1"

    print(f"Smart Agriculture AI API running on http://{host}:{port} | debug={debug_mode}")
    app.run(host=host, port=port, debug=debug_mode)
