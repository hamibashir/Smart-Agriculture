# ============================================================
# Smart Agriculture - Crop Recommendation AI Model
# Train & Export Script
# ============================================================

import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
import joblib
import json
import os

print("=" * 55)
print("  Smart Agriculture - Crop Recommendation Model")
print("=" * 55)

# ── 1. Load Dataset ──────────────────────────────────────────
df = pd.read_csv("dataset/crop_dataset.csv")
print(f"\n✅ Dataset loaded: {len(df)} rows, {len(df.columns)} columns")
print(f"   Crops in dataset: {df['recommended_crop'].unique().tolist()}")
print(f"   Seasons: {df['season'].unique().tolist()}")
print(f"   Soil types: {df['soil_type'].unique().tolist()}")

# ── 2. Encode Categorical Columns ────────────────────────────
le_soil   = LabelEncoder()
le_season = LabelEncoder()
le_crop   = LabelEncoder()

df["soil_type_enc"] = le_soil.fit_transform(df["soil_type"])
df["season_enc"]    = le_season.fit_transform(df["season"])
df["crop_enc"]      = le_crop.fit_transform(df["recommended_crop"])

# ── 3. Features & Label ──────────────────────────────────────
FEATURES = ["soil_moisture", "temperature", "humidity",
            "soil_type_enc", "season_enc"]

X = df[FEATURES]
y = df["crop_enc"]

# ── 4. Train/Test Split ──────────────────────────────────────
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)
print(f"\n✅ Train: {len(X_train)} rows | Test: {len(X_test)} rows")

# ── 5. Train Random Forest ───────────────────────────────────
model = RandomForestClassifier(
    n_estimators=100,
    max_depth=10,
    random_state=42
)
model.fit(X_train, y_train)
print("\n✅ Model trained successfully!")

# ── 6. Evaluate ──────────────────────────────────────────────
y_pred    = model.predict(X_test)
accuracy  = accuracy_score(y_test, y_pred)
print(f"\n📊 Accuracy: {accuracy * 100:.2f}%")
print("\n📊 Classification Report:")
print(classification_report(
    y_test, y_pred,
    target_names=le_crop.classes_
))

# ── 7. Feature Importance ────────────────────────────────────
importances = model.feature_importances_
print("\n📊 Feature Importances:")
for feat, imp in zip(FEATURES, importances):
    bar = "█" * int(imp * 40)
    print(f"   {feat:<20} {bar} {imp:.4f}")

# ── 8. Save Model & Encoders ─────────────────────────────────
os.makedirs("model", exist_ok=True)

joblib.dump(model,     "model/crop_model.pkl")
joblib.dump(le_soil,   "model/le_soil.pkl")
joblib.dump(le_season, "model/le_season.pkl")
joblib.dump(le_crop,   "model/le_crop.pkl")

# Save label mappings for reference
mappings = {
    "soil_types":  list(le_soil.classes_),
    "seasons":     list(le_season.classes_),
    "crops":       list(le_crop.classes_),
    "features":    FEATURES,
    "accuracy":    round(accuracy * 100, 2)
}
with open("model/mappings.json", "w") as f:
    json.dump(mappings, f, indent=2)

print("\n✅ Model saved to model/crop_model.pkl")
print("✅ Encoders saved to model/")
print("✅ Mappings saved to model/mappings.json")

# ── 9. Quick Prediction Test ─────────────────────────────────
print("\n" + "=" * 55)
print("  LIVE PREDICTION TEST")
print("=" * 55)

def predict_crop(soil_moisture, temperature, humidity, soil_type, season):
    soil_enc   = le_soil.transform([soil_type])[0]
    season_enc = le_season.transform([season])[0]
    features   = [[soil_moisture, temperature, humidity, soil_enc, season_enc]]
    prediction = model.predict(features)[0]
    proba      = model.predict_proba(features)[0]
    crop       = le_crop.inverse_transform([prediction])[0]
    confidence = round(max(proba) * 100, 2)
    return crop, confidence

# Test cases matching Pakistan conditions
tests = [
    (42, 28, 65, "loamy",  "rabi",   "Should → Wheat"),
    (70, 32, 80, "clay",   "kharif", "Should → Rice"),
    (36, 31, 59, "sandy",  "kharif", "Should → Cotton"),
    (55, 25, 70, "loamy",  "kharif", "Should → Maize"),
    (28, 19, 48, "sandy",  "rabi",   "Should → Mustard"),
]

for sm, temp, hum, soil, season, expected in tests:
    crop, conf = predict_crop(sm, temp, hum, soil, season)
    print(f"  Input: moisture={sm}%, temp={temp}°C, soil={soil}, season={season}")
    print(f"  ➜ Predicted: {crop.upper()} ({conf}%) | {expected}")
    print()

print("=" * 55)
print("  Training Complete! Next: run app.py (Flask API)")
print("=" * 55)
