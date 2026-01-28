class AppConfig {
  // ========== API Configuration ==========
  // IMPORTANT: Choose the correct URL based on your testing environment:
  
  // 1. For Android Emulator (connects to host machine's localhost)
  // static const String apiBaseUrl = 'http://10.0.2.2:5000/api';
  
  // 2. For iOS Simulator (connects to host machine's localhost)
  // static const String apiBaseUrl = 'http://localhost:5000/api';
  
  // 3. For Physical Device (use your computer's local IP address)
  // Find your IP: Windows (ipconfig), Mac/Linux (ifconfig)
  static const String apiBaseUrl = 'http://192.168.18.10:5000/api';
  
  // 4. For Production (use your deployed backend URL)
  // static const String apiBaseUrl = 'https://your-domain.com/api';
  
  static const String apiTimeout = '30';
  
  // App Information
  static const String appName = 'Smart Agriculture';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  
  // Theme Colors (matching web app)
  static const int primaryGreen = 0xFF22c55e;
  static const int darkGreen = 0xFF16a34a;
  static const int lightGreen = 0xFF86efac;
  static const int backgroundColor = 0xFFf9fafb;
  static const int cardColor = 0xFFffffff;
  static const int textPrimary = 0xFF111827;
  static const int textSecondary = 0xFF6b7280;
  
  // Pagination
  static const int pageSize = 20;
  
  // Refresh Intervals (seconds)
  static const int dashboardRefresh = 30;
  static const int sensorRefresh = 10;
}
