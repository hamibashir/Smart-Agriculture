class CropRecommendation {
  final int recommendationId;
  final int fieldId;
  final String recommendedCrop;
  final double? confidenceScore;
  final double? soilMoistureAvg;
  final double? temperatureAvg;
  final double? humidityAvg;
  final String? soilType;
  final String? season;
  final double? expectedYield;
  final String? waterRequirement;
  final int? growthDurationDays;
  final String? recommendationReason;
  final String? modelVersion;
  final bool isAccepted;
  final DateTime? acceptedAt;
  final DateTime createdAt;

  CropRecommendation({
    required this.recommendationId,
    required this.fieldId,
    required this.recommendedCrop,
    this.confidenceScore,
    this.soilMoistureAvg,
    this.temperatureAvg,
    this.humidityAvg,
    this.soilType,
    this.season,
    this.expectedYield,
    this.waterRequirement,
    this.growthDurationDays,
    this.recommendationReason,
    this.modelVersion,
    required this.isAccepted,
    this.acceptedAt,
    required this.createdAt,
  });

  factory CropRecommendation.fromJson(Map<String, dynamic> json) {
    return CropRecommendation(
      recommendationId: json['recommendation_id'],
      fieldId: json['field_id'],
      recommendedCrop: json['recommended_crop'],
      confidenceScore: json['confidence_score'] != null 
          ? double.tryParse(json['confidence_score'].toString()) 
          : null,
      soilMoistureAvg: json['soil_moisture_avg'] != null 
          ? double.tryParse(json['soil_moisture_avg'].toString()) 
          : null,
      temperatureAvg: json['temperature_avg'] != null 
          ? double.tryParse(json['temperature_avg'].toString()) 
          : null,
      humidityAvg: json['humidity_avg'] != null 
          ? double.tryParse(json['humidity_avg'].toString()) 
          : null,
      soilType: json['soil_type'],
      season: json['season'],
      expectedYield: json['expected_yield'] != null 
          ? double.tryParse(json['expected_yield'].toString()) 
          : null,
      waterRequirement: json['water_requirement'],
      growthDurationDays: json['growth_duration_days'],
      recommendationReason: json['recommendation_reason'],
      modelVersion: json['model_version'],
      isAccepted: json['is_accepted'] == 1 || json['is_accepted'] == true,
      acceptedAt: json['accepted_at'] != null 
          ? DateTime.parse(json['accepted_at']) 
          : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
