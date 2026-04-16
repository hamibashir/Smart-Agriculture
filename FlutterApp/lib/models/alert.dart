class Alert {
  final int alertId;
  final int userId;
  final int? fieldId;
  final int? sensorId;
  final String alertType;
  final String alertCategory;
  final String title;
  final String message;
  final double? thresholdValue;
  final double? currentValue;
  final bool isRead;
  final bool isResolved;
  final DateTime? resolvedAt;
  final String? actionTaken;
  final bool? pushNotificationSent;
  final bool? emailSent;
  final DateTime createdAt;

  const Alert({
    required this.alertId,
    required this.userId,
    this.fieldId,
    this.sensorId,
    required this.alertType,
    required this.alertCategory,
    required this.title,
    required this.message,
    this.thresholdValue,
    this.currentValue,
    required this.isRead,
    required this.isResolved,
    this.resolvedAt,
    this.actionTaken,
    this.pushNotificationSent,
    this.emailSent,
    required this.createdAt,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        alertId: json['alert_id'],
        userId: json['user_id'],
        fieldId: json['field_id'],
        sensorId: json['sensor_id'],
        alertType: json['alert_type'],
        alertCategory: json['alert_category'],
        title: json['title'],
        message: json['message'],
        thresholdValue: _parseDouble(json['threshold_value']),
        currentValue: _parseDouble(json['current_value']),
        isRead: _parseBool(json['is_read']),
        isResolved: _parseBool(json['is_resolved']),
        resolvedAt: json['resolved_at'] != null ? DateTime.parse(json['resolved_at']).toLocal() : null,
        actionTaken: json['action_taken'],
        pushNotificationSent: _parseBool(json['push_notification_sent']),
        emailSent: _parseBool(json['email_sent']),
        createdAt: DateTime.parse(json['created_at']).toLocal(),
      );

  static double? _parseDouble(dynamic value) => value != null ? double.tryParse(value.toString()) : null;

  static bool _parseBool(dynamic value) => value == 1 || value == true;
}
