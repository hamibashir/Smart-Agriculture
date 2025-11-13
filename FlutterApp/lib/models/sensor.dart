class Sensor {
  final int sensorId;
  final int fieldId;
  final String sensorType;
  final String deviceId;
  final String? sensorModel;
  final DateTime installationDate;
  final String? locationDescription;
  final bool isActive;
  final double? batteryLevel;
  final String? firmwareVersion;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Sensor({
    required this.sensorId,
    required this.fieldId,
    required this.sensorType,
    required this.deviceId,
    this.sensorModel,
    required this.installationDate,
    this.locationDescription,
    required this.isActive,
    this.batteryLevel,
    this.firmwareVersion,
    this.createdAt,
    this.updatedAt,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      sensorId: json['sensor_id'],
      fieldId: json['field_id'],
      sensorType: json['sensor_type'],
      deviceId: json['device_id'],
      sensorModel: json['sensor_model'],
      installationDate: DateTime.parse(json['installation_date']),
      locationDescription: json['location_description'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      batteryLevel: json['battery_level'] != null 
          ? double.tryParse(json['battery_level'].toString()) 
          : null,
      firmwareVersion: json['firmware_version'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}

class SensorReading {
  final int readingId;
  final int sensorId;
  final double? soilMoisture;
  final double? temperature;
  final double? humidity;
  final double? lightIntensity;
  final double? rainfall;
  final DateTime readingTimestamp;

  SensorReading({
    required this.readingId,
    required this.sensorId,
    this.soilMoisture,
    this.temperature,
    this.humidity,
    this.lightIntensity,
    this.rainfall,
    required this.readingTimestamp,
  });

  factory SensorReading.fromJson(Map<String, dynamic> json) {
    return SensorReading(
      readingId: json['reading_id'],
      sensorId: json['sensor_id'],
      soilMoisture: json['soil_moisture'] != null 
          ? double.tryParse(json['soil_moisture'].toString()) 
          : null,
      temperature: json['temperature'] != null 
          ? double.tryParse(json['temperature'].toString()) 
          : null,
      humidity: json['humidity'] != null 
          ? double.tryParse(json['humidity'].toString()) 
          : null,
      lightIntensity: json['light_intensity'] != null 
          ? double.tryParse(json['light_intensity'].toString()) 
          : null,
      rainfall: json['rainfall'] != null 
          ? double.tryParse(json['rainfall'].toString()) 
          : null,
      readingTimestamp: DateTime.parse(json['reading_timestamp']),
    );
  }
}
