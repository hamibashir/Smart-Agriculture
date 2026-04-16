from flask import Flask, request, jsonify
import joblib
import json
import os

app = Flask(__name__)

# ── Load Model & Encoders ────────────────────────────────────
model     = joblib.load("model/crop_model.pkl")
le_soil   = joblib.load("model/le_soil.pkl")
le_season = joblib.load("model/le_season.pkl")
le_crop   = joblib.load("model/le_crop.pkl")

with open("model/mappings.json") as f:
    mappings = json.load(f)

# Crop info lookup (water needs, yield, growth days)
CROP_INFO = {
    "wheat":     {"water": "Medium", "yield": 2800, "days": 120},
    "rice":      {"water": "High",   "yield": 3500, "days": 150},
    "cotton":    {"water": "Low",    "yield": 1200, "days": 180},
    "maize":     {"water": "Medium", "yield": 3000, "days": 90},
    "sugarcane": {"water": "High",   "yield": 50000,"days": 365},
    "mustard":   {"water": "Low",    "yield": 1000, "days": 110},
    "chickpea":  {"water": "Low",    "yield": 900,  "days": 100},
    "sunflower": {"water": "Medium", "yield": 1500, "days": 100},
}


@app.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "ok",
        "model_accuracy": f"{mappings['accuracy']}%",
        "crops_supported": mappings["crops"]
    })


@app.route("/predict", methods=["POST"])
def predict():
    try:
        data = request.get_json()

        # Required fields
        soil_moisture = float(data["soil_moisture"])
        temperature   = float(data["temperature"])
        humidity      = float(data["humidity"])
        soil_type     = data["soil_type"].lower()
        season        = data["season"].lower()
        rainfall      = float(data.get("rainfall", 0))

        # Validate soil_type & season
        if soil_type not in le_soil.classes_:
            return jsonify({
                "success": False,
                "message": f"Invalid soil_type. Valid: {list(le_soil.classes_)}"
            }), 400

        if season not in le_season.classes_:
            return jsonify({
                "success": False,
                "message": f"Invalid season. Valid: {list(le_season.classes_)}"
            }), 400

        # Encode
        soil_enc   = le_soil.transform([soil_type])[0]
        season_enc = le_season.transform([season])[0]

        # Predict
        features   = [[soil_moisture, temperature, humidity, soil_enc, season_enc, rainfall]]
        prediction = model.predict(features)[0]
        proba      = model.predict_proba(features)[0]
        crop       = le_crop.inverse_transform([prediction])[0]
        confidence = round(max(proba) * 100, 2)

        # Get top 3 alternatives
        top3_idx  = proba.argsort()[-3:][::-1]
        top3      = [
            {"crop": le_crop.inverse_transform([i])[0], "confidence": round(proba[i] * 100, 2)}
            for i in top3_idx
        ]

        # Crop metadata
        info   = CROP_INFO.get(crop, {})
        reason = (
            f"Based on soil moisture ({soil_moisture}%), temperature ({temperature}°C), "
            f"humidity ({humidity}%), {soil_type} soil, and {season} season conditions, "
            f"{crop.title()} is the most suitable crop."
        )

        # Generate "What-If" Insights for the presentation panel
        features_hot = [[soil_moisture, temperature + 4, humidity, soil_enc, season_enc, rainfall]]
        features_cold = [[soil_moisture, temperature - 4, humidity, soil_enc, season_enc, rainfall]]
        features_wet = [[soil_moisture + 15, temperature, humidity, soil_enc, season_enc, rainfall]]

        crop_hot = le_crop.inverse_transform([model.predict(features_hot)[0]])[0]
        crop_cold = le_crop.inverse_transform([model.predict(features_cold)[0]])[0]
        crop_wet = le_crop.inverse_transform([model.predict(features_wet)[0]])[0]

        what_ifs = []
        if crop_hot != crop:
            what_ifs.append(f"If temp was +4°C hotter, {crop_hot.title()} would be recommended.")
        if crop_cold != crop:
            what_ifs.append(f"If temp was -4°C cooler, {crop_cold.title()} would be recommended.")
        if len(what_ifs) < 2 and crop_wet != crop:
            what_ifs.append(f"If soil moisture was +15% higher, {crop_wet.title()} would be recommended.")
            
        if what_ifs:
            reason += "\n\n💡 Alternative Scenarios: " + " ".join(what_ifs)

        return jsonify({
            "success":          True,
            "recommended_crop": crop,
            "confidence_score": confidence,
            "alternatives":     top3,
            "water_requirement":     info.get("water", "Medium"),
            "expected_yield":        info.get("yield", 0),
            "growth_duration_days":  info.get("days", 0),
            "recommendation_reason": reason,
            "model_version":         "1.0.0",
            "inputs": {
                "soil_moisture": soil_moisture,
                "temperature":   temperature,
                "humidity":      humidity,
                "soil_type":     soil_type,
                "season":        season,
                "rainfall":      rainfall
            }
        })

    except KeyError as e:
        return jsonify({"success": False, "message": f"Missing field: {e}"}), 400
    except Exception as e:
        return jsonify({"success": False, "message": str(e)}), 500


@app.route("/crops", methods=["GET"])
def get_crops():
    return jsonify({
        "success": True,
        "crops":      mappings["crops"],
        "soil_types": mappings["soil_types"],
        "seasons":    mappings["seasons"]
    })


if __name__ == "__main__":
    print("🌾 Smart Agriculture AI API running on http://localhost:5001")
    app.run(host="0.0.0.0", port=5001, debug=True)
