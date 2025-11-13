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

  Alert({
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

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      alertId: json['alert_id'],
      userId: json['user_id'],
      fieldId: json['field_id'],
      sensorId: json['sensor_id'],
      alertType: json['alert_type'],
      alertCategory: json['alert_category'],
      title: json['title'],
      message: json['message'],
      thresholdValue: json['threshold_value'] != null 
          ? double.tryParse(json['threshold_value'].toString()) 
          : null,
      currentValue: json['current_value'] != null 
          ? double.tryParse(json['current_value'].toString()) 
          : null,
      isRead: json['is_read'] == 1 || json['is_read'] == true,
      isResolved: json['is_resolved'] == 1 || json['is_resolved'] == true,
      resolvedAt: json['resolved_at'] != null ? DateTime.parse(json['resolved_at']) : null,
      actionTaken: json['action_taken'],
      pushNotificationSent: json['push_notification_sent'] == 1 || json['push_notification_sent'] == true,
      emailSent: json['email_sent'] == 1 || json['email_sent'] == true,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
