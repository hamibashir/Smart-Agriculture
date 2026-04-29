class AppConfig {
  AppConfig._();

  // ============================================================
  // Environment Switch
  // Development: false
  // Production (current): true
  // ============================================================
  static const bool useProduction = true;

  // Development URL (local backend)
  static const String developmentApiBaseUrl = 'http://192.168.18.73:5000/api';

  // Production URL
  static const String productionApiBaseUrl = 'https://api.hamzabashir.online/api';

  // Active base URL used by the app
  static const String apiBaseUrl =
      useProduction ? productionApiBaseUrl : developmentApiBaseUrl;

  // ============================================================
  // Other shared settings
  // ============================================================
  static const int apiTimeout = 30;

  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
}
