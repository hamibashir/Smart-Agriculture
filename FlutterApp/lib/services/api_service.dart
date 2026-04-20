import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  String? _token;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(AppConfig.tokenKey);

    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: AppConfig.apiTimeout),
      receiveTimeout: const Duration(seconds: AppConfig.apiTimeout),
      headers: {'Content-Type': 'application/json'},
    ))..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) options.headers['Authorization'] = 'Bearer $_token';
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) await clearToken();
          handler.next(error);
        },
      ));
  }

  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.tokenKey, token);
  }

  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.tokenKey);
    await prefs.remove(AppConfig.userKey);
  }

  Future<Map<String, dynamic>> _request(String method, String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await switch (method) {
        'GET' => _dio.get(endpoint),
        'POST' => _dio.post(endpoint, data: data),
        'PUT' => _dio.put(endpoint, data: data),
        'DELETE' => _dio.delete(endpoint),
        _ => throw Exception('Invalid method'),
      };
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Network error');
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) => _request('GET', endpoint);
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) => _request('POST', endpoint, data: data);
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) => _request('PUT', endpoint, data: data);
  Future<Map<String, dynamic>> delete(String endpoint) => _request('DELETE', endpoint);

  Future<Map<String, dynamic>> login(String email, String password) => post('/auth/login', {'email': email, 'password': password});
  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) => post('/auth/register', userData);
  Future<Map<String, dynamic>> getProfile() => get('/auth/profile');
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) => put('/auth/profile', data);

  Future<Map<String, dynamic>> getFields() => get('/fields');
  Future<Map<String, dynamic>> getField(int fieldId) => get('/fields/$fieldId');
  Future<Map<String, dynamic>> createField(Map<String, dynamic> data) => post('/fields', data);
  Future<Map<String, dynamic>> updateField(int fieldId, Map<String, dynamic> data) => put('/fields/$fieldId', data);
  Future<Map<String, dynamic>> deleteField(int fieldId) => delete('/fields/$fieldId');

  Future<Map<String, dynamic>> getFieldSensors(int fieldId) => get('/sensors/field/$fieldId');
  Future<Map<String, dynamic>> getSensorReadings(int sensorId) => get('/sensors/$sensorId/readings');
  Future<Map<String, dynamic>> getLatestReading(int sensorId) => get('/sensors/$sensorId/latest');
  Future<Map<String, dynamic>> createSensor(Map<String, dynamic> data) => post('/sensors', data);
  Future<Map<String, dynamic>> bindSensorToField(int sensorId, int fieldId) => put('/sensors/$sensorId', {'field_id': fieldId});

  Future<Map<String, dynamic>> getIrrigationLogs(int fieldId) => get('/irrigation/logs/$fieldId');
  Future<Map<String, dynamic>> startIrrigation(Map<String, dynamic> data) => post('/irrigation/start', data);
  Future<Map<String, dynamic>> stopIrrigation(int fieldId) => post('/irrigation/stop', {'field_id': fieldId});
  Future<Map<String, dynamic>> getIrrigationSchedules(int fieldId) => get('/irrigation/schedules/$fieldId');

  Future<Map<String, dynamic>> getAlerts() => get('/alerts');
  Future<Map<String, dynamic>> getUnreadCount() => get('/alerts/unread-count');
  Future<Map<String, dynamic>> markAsRead(int alertId) => put('/alerts/$alertId/read', {});
  Future<Map<String, dynamic>> resolveAlert(int alertId) => put('/alerts/$alertId/resolve', {});
  Future<Map<String, dynamic>> deleteAlert(int alertId) => delete('/alerts/$alertId');

  Future<Map<String, dynamic>> getDashboardStats({int? fieldId}) {
    final query = fieldId != null ? '?field_id=$fieldId' : '';
    return get('/dashboard/stats$query');
  }
  Future<Map<String, dynamic>> getDashboardActivity() => get('/dashboard/activity');

  Future<Map<String, dynamic>> getRecommendations(int fieldId) => get('/recommendations/$fieldId');
  Future<Map<String, dynamic>> acceptRecommendation(int recommendationId) async {
    return put('/recommendations/$recommendationId/accept', {});
  }

  Future<Map<String, dynamic>> deleteRecommendation(int recommendationId) async {
    return delete('/recommendations/$recommendationId');
  }

  Future<Map<String, dynamic>> generateRecommendation(int fieldId, String season) async {
    return post('/recommendations/$fieldId/generate', {'season': season});
  }

  Future<Map<String, dynamic>> sendChatMessage(String message, {int? fieldId}) async {
    return post('/chat', {
      'message': message,
      if (fieldId != null) 'fieldId': fieldId,
    });
  }
}
