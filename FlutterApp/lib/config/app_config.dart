class AppConfig {
  AppConfig._();

  static const String apiBaseUrl = 'http://192.168.18.10:5000/api';
  static const int apiTimeout = 30;

  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
}