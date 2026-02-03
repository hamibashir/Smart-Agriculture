class AppConfig {
  static const String apiBaseUrl = 'http://192.168.18.10:5000/api';
  static const int apiTimeout = 30;
  
  static const String appName = 'Smart Agriculture';
  static const String appVersion = '1.0.0';
  
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  
  static const int primaryGreen = 0xFF22c55e;
  static const int darkGreen = 0xFF16a34a;
  static const int lightGreen = 0xFF86efac;
  static const int backgroundColor = 0xFFf9fafb;
  static const int cardColor = 0xFFffffff;
  static const int textPrimary = 0xFF111827;
  static const int textSecondary = 0xFF6b7280;
  
  static const int pageSize = 20;
  static const int dashboardRefresh = 30;
  static const int sensorRefresh = 10;
}