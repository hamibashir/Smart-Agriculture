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

  IrrigationLog({
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

  factory IrrigationLog.fromJson(Map<String, dynamic> json) {
    return IrrigationLog(
      logId: json['log_id'],
      fieldId: json['field_id'],
      sensorId: json['sensor_id'],
      irrigationType: json['irrigation_type'],
      startTime: DateTime.parse(json['start_time']),
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      durationMinutes: json['duration_minutes'],
      waterUsedLiters: json['water_used_liters'] != null ? double.tryParse(json['water_used_liters'].toString()) : null,
      triggerReason: json['trigger_reason'],
      soilMoistureBefore: json['soil_moisture_before'] != null ? double.tryParse(json['soil_moisture_before'].toString()) : null,
      soilMoistureAfter: json['soil_moisture_after'] != null ? double.tryParse(json['soil_moisture_after'].toString()) : null,
      pumpStatus: json['pump_status'],
      initiatedBy: json['initiated_by'],
      notes: json['notes'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }
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

  IrrigationSchedule({
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

  factory IrrigationSchedule.fromJson(Map<String, dynamic> json) {
    return IrrigationSchedule(
      scheduleId: json['schedule_id'],
      fieldId: json['field_id'],
      scheduleName: json['schedule_name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      timeOfDay: json['time_of_day'],
      durationMinutes: json['duration_minutes'],
      frequency: json['frequency'],
      customDays: json['custom_days'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
    );
  }
}