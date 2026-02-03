class Field {
  final int fieldId;
  final int userId;
  final String fieldName;
  final double? locationLatitude;
  final double? locationLongitude;
  final double areaSize;
  final String areaUnit;
  final String? soilType;
  final String? currentCrop;
  final DateTime? plantingDate;
  final DateTime? expectedHarvestDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Field({
    required this.fieldId,
    required this.userId,
    required this.fieldName,
    this.locationLatitude,
    this.locationLongitude,
    required this.areaSize,
    required this.areaUnit,
    this.soilType,
    this.currentCrop,
    this.plantingDate,
    this.expectedHarvestDate,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        fieldId: json['field_id'],
        userId: json['user_id'],
        fieldName: json['field_name'],
        locationLatitude: _parseDouble(json['location_latitude']),
        locationLongitude: _parseDouble(json['location_longitude']),
        areaSize: double.parse(json['area_size'].toString()),
        areaUnit: json['area_unit'] ?? 'acres',
        soilType: json['soil_type'],
        currentCrop: json['current_crop'],
        plantingDate: _parseDateTime(json['planting_date']),
        expectedHarvestDate: _parseDateTime(json['expected_harvest_date']),
        isActive: json['is_active'] == 1 || json['is_active'] == true,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: _parseDateTime(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'field_id': fieldId,
        'user_id': userId,
        'field_name': fieldName,
        'location_latitude': locationLatitude,
        'location_longitude': locationLongitude,
        'area_size': areaSize,
        'area_unit': areaUnit,
        'soil_type': soilType,
        'current_crop': currentCrop,
        'planting_date': plantingDate?.toIso8601String(),
        'expected_harvest_date': expectedHarvestDate?.toIso8601String(),
        'is_active': isActive,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  static double? _parseDouble(dynamic value) => value != null ? double.tryParse(value.toString()) : null;

  static DateTime? _parseDateTime(dynamic value) => value != null ? DateTime.parse(value) : null;
}