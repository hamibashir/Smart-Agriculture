class IrrigationLog {
  final int logId;
  final int fieldId;
  final int? sensorId;
  final String irrigationType;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final double? waterUsedLiters;
  final String? triggerReason;
  final double? soilMoistureBefore;
  final double? soilMoistureAfter;
  final String pumpStatus;
  final int? initiatedBy;
  final String? notes;
  final DateTime? createdAt;

  const IrrigationLog({
    required this.logId,
    required this.fieldId,
    this.sensorId,
    required this.irrigationType,
    required this.startTime,
    this.endTime,
    this.durationMinutes,
    this.waterUsedLiters,
    this.triggerReason,
    this.soilMoistureBefore,
    this.soilMoistureAfter,
    required this.pumpStatus,
    this.initiatedBy,
    this.notes,
    this.createdAt,
  });

  factory IrrigationLog.fromJson(Map<String, dynamic> json) => IrrigationLog(
        logId: json['log_id'],
        fieldId: json['field_id'],
        sensorId: json['sensor_id'],
        irrigationType: json['irrigation_type'],
        startTime: DateTime.parse(json['start_time']),
        endTime: _parseDateTime(json['end_time']),
        durationMinutes: json['duration_minutes'],
        waterUsedLiters: _parseDouble(json['water_used_liters']),
        triggerReason: json['trigger_reason'],
        soilMoistureBefore: _parseDouble(json['soil_moisture_before']),
        soilMoistureAfter: _parseDouble(json['soil_moisture_after']),
        pumpStatus: json['pump_status'],
        initiatedBy: json['initiated_by'],
        notes: json['notes'],
        createdAt: _parseDateTime(json['created_at']),
      );

  static double? _parseDouble(dynamic value) => value != null ? double.tryParse(value.toString()) : null;

  static DateTime? _parseDateTime(dynamic value) => value != null ? DateTime.parse(value) : null;
}

class IrrigationSchedule {
  final int scheduleId;
  final int fieldId;
  final String scheduleName;
  final DateTime startDate;
  final DateTime? endDate;
  final String timeOfDay;
  final int durationMinutes;
  final String frequency;
  final String? customDays;
  final bool isActive;

  const IrrigationSchedule({
    required this.scheduleId,
    required this.fieldId,
    required this.scheduleName,
    required this.startDate,
    this.endDate,
    required this.timeOfDay,
    required this.durationMinutes,
    required this.frequency,
    this.customDays,
    required this.isActive,
  });

  factory IrrigationSchedule.fromJson(Map<String, dynamic> json) => IrrigationSchedule(
        scheduleId: json['schedule_id'],
        fieldId: json['field_id'],
        scheduleName: json['schedule_name'],
        startDate: DateTime.parse(json['start_date']),
        endDate: _parseDateTime(json['end_date']),
        timeOfDay: json['time_of_day'],
        durationMinutes: json['duration_minutes'],
        frequency: json['frequency'],
        customDays: json['custom_days'],
        isActive: json['is_active'] == 1 || json['is_active'] == true,
      );

  static DateTime? _parseDateTime(dynamic value) => value != null ? DateTime.parse(value) : null;
}