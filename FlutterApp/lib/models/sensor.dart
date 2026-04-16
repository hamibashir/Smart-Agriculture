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

  const Sensor({
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

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
        sensorId: json['sensor_id'],
        fieldId: json['field_id'],
        sensorType: json['sensor_type'],
        deviceId: json['device_id'],
        sensorModel: json['sensor_model'],
        installationDate: DateTime.parse(json['installation_date']),
        locationDescription: json['location_description'],
        isActive: json['is_active'] == 1 || json['is_active'] == true,
        batteryLevel: _parseDouble(json['battery_level']),
        firmwareVersion: json['firmware_version'],
        createdAt: _parseDateTime(json['created_at']),
        updatedAt: _parseDateTime(json['updated_at']),
      );

  static double? _parseDouble(dynamic value) => value != null ? double.tryParse(value.toString()) : null;

  static DateTime? _parseDateTime(dynamic value) => value != null ? DateTime.parse(value).toLocal() : null;
}

class SensorReading {
  final int readingId;
  final int sensorId;
  final DateTime timestamp;
  final double? soilMoisture;
  final double? temperature;
  final double? humidity;
  final double? lightIntensity;

  const SensorReading({
    required this.readingId,
    required this.sensorId,
    required this.timestamp,
    this.soilMoisture,
    this.temperature,
    this.humidity,
    this.lightIntensity,
  });

  factory SensorReading.fromJson(Map<String, dynamic> json) => SensorReading(
        readingId: json['reading_id'],
        sensorId: json['sensor_id'],
        timestamp: DateTime.parse(json['reading_time']).toLocal(),
        soilMoisture: _parseDouble(json['soil_moisture']),
        temperature: _parseDouble(json['temperature']),
        humidity: _parseDouble(json['humidity']),
        lightIntensity: _parseDouble(json['light_intensity']),
      );

  static double? _parseDouble(dynamic value) => value != null ? double.tryParse(value.toString()) : null;
}
