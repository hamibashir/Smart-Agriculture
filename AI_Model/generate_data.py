import pandas as pd
import numpy as np
import random
import os

# Real agricultural rules for Pakistan
crop_rules = {
    "wheat":     {"temp": (15, 25), "moisture": (40, 60), "humidity": (50, 70), "season": "rabi",   "soils": ["loamy", "clay_loam", "silty"]},
    "rice":      {"temp": (25, 35), "moisture": (70, 95), "humidity": (75, 90), "season": "kharif", "soils": ["clay", "silty"]},
    "cotton":    {"temp": (28, 38), "moisture": (30, 50), "humidity": (50, 65), "season": "kharif", "soils": ["sandy", "loamy"]},
    "maize":     {"temp": (20, 30), "moisture": (50, 70), "humidity": (60, 80), "season": "kharif", "soils": ["loamy", "clay_loam"]},
    "sugarcane": {"temp": (25, 35), "moisture": (60, 85), "humidity": (70, 85), "season": "kharif", "soils": ["clay", "clay_loam"]},
    "mustard":   {"temp": (10, 20), "moisture": (25, 45), "humidity": (40, 60), "season": "rabi",   "soils": ["sandy", "loamy"]},
    "chickpea":  {"temp": (15, 25), "moisture": (30, 50), "humidity": (45, 65), "season": "rabi",   "soils": ["loamy", "clay_loam"]},
    "sunflower": {"temp": (20, 30), "moisture": (40, 60), "humidity": (50, 70), "season": "kharif", "soils": ["loamy", "sandy"]}
}

data = []
rows_per_crop = 350 # 8 crops * 350 = 2800 total rows

for crop, rules in crop_rules.items():
    for _ in range(rows_per_crop):
        temp  = round(random.uniform(*rules["temp"])     + random.gauss(0, 1.5), 1)
        moist = round(random.uniform(*rules["moisture"]) + random.gauss(0, 2.0), 1)
        hum   = round(random.uniform(*rules["humidity"]) + random.gauss(0, 2.0), 1)
        soil  = random.choice(rules["soils"])

        data.append([moist, temp, hum, soil, rules["season"], crop])

df = pd.DataFrame(data, columns=["soil_moisture", "temperature", "humidity", "soil_type", "season", "recommended_crop"])
df = df.sample(frac=1).reset_index(drop=True)

os.makedirs("dataset", exist_ok=True)
df.to_csv("dataset/crop_dataset.csv", index=False)

print("✅ Generated 2800 rows — rainfall removed, 5-feature dataset ready!")
