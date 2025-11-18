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

  Field({
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

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      fieldId: json['field_id'],
      userId: json['user_id'],
      fieldName: json['field_name'],
      locationLatitude: json['location_latitude'] != null 
          ? double.tryParse(json['location_latitude'].toString()) 
          : null,
      locationLongitude: json['location_longitude'] != null 
          ? double.tryParse(json['location_longitude'].toString()) 
          : null,
      areaSize: double.parse(json['area_size'].toString()),
      areaUnit: json['area_unit'] ?? 'acres',
      soilType: json['soil_type'],
      currentCrop: json['current_crop'],
      plantingDate: json['planting_date'] != null 
          ? DateTime.parse(json['planting_date']) 
          : null,
      expectedHarvestDate: json['expected_harvest_date'] != null 
          ? DateTime.parse(json['expected_harvest_date']) 
          : null,
isActive: json['is_active'] == 1 || json['is_active'] == true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}
