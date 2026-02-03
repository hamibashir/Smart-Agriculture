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

  const CropRecommendation({
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

  factory CropRecommendation.fromJson(Map<String, dynamic> json) => CropRecommendation(
        recommendationId: json['recommendation_id'],
        fieldId: json['field_id'],
        recommendedCrop: json['recommended_crop'],
        confidenceScore: _parseDouble(json['confidence_score']),
        soilMoistureAvg: _parseDouble(json['soil_moisture_avg']),
        temperatureAvg: _parseDouble(json['temperature_avg']),
        humidityAvg: _parseDouble(json['humidity_avg']),
        soilType: json['soil_type'],
        season: json['season'],
        expectedYield: _parseDouble(json['expected_yield']),
        waterRequirement: json['water_requirement'],
        growthDurationDays: json['growth_duration_days'],
        recommendationReason: json['recommendation_reason'],
        modelVersion: json['model_version'],
        isAccepted: json['is_accepted'] == 1 || json['is_accepted'] == true,
        acceptedAt: _parseDateTime(json['accepted_at']),
        createdAt: DateTime.parse(json['created_at']),
      );

  static double? _parseDouble(dynamic value) => value != null ? double.tryParse(value.toString()) : null;

  static DateTime? _parseDateTime(dynamic value) => value != null ? DateTime.parse(value) : null;
}
