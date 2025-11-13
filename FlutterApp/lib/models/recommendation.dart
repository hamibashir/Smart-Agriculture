class CropRecommendation {
  final int recommendationId;
  final int fieldId;
  final String recommendedCrop;
  final double confidenceScore;
  final double? soilMoistureAvg;
  final double? temperatureAvg;
  final double? humidityAvg;
  final String? soilType;
  final String? season;
  final double? expectedYield;
  final String? waterRequirement;
  final int? growthDurationDays;
  final String? recommendationReason;
  final bool isAccepted;
  final DateTime createdAt;

  CropRecommendation({
    required this.recommendationId,
    required this.fieldId,
    required this.recommendedCrop,
    required this.confidenceScore,
    this.soilMoistureAvg,
    this.temperatureAvg,
    this.humidityAvg,
    this.soilType,
    this.season,
    this.expectedYield,
    this.waterRequirement,
    this.growthDurationDays,
    this.recommendationReason,
    required this.isAccepted,
    required this.createdAt,
  });

  factory CropRecommendation.fromJson(Map<String, dynamic> json) {
    return CropRecommendation(
      recommendationId: json['recommendation_id'],
      fieldId: json['field_id'],
      recommendedCrop: json['recommended_crop'],
      confidenceScore: double.parse(json['confidence_score'].toString()),
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
      isAccepted: json['is_accepted'] == 1 || json['is_accepted'] == true,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
