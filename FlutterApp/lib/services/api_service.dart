import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _token;

  // Initialize token from storage
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(AppConfig.tokenKey);
  }

  // Set token
  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.tokenKey, token);
  }

  // Clear token
  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.tokenKey);
    await prefs.remove(AppConfig.userKey);
  }

  // Get headers
  Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // Generic GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final url = Uri.parse('${AppConfig.apiBaseUrl}$endpoint');
      final response = await http.get(url, headers: _getHeaders());
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Generic POST request
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final url = Uri.parse('${AppConfig.apiBaseUrl}$endpoint');
      print('🌐 POST Request to: $url');
      print('📤 Request data: $data');
      print('📋 Headers: ${_getHeaders()}');
      
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: json.encode(data),
      ).timeout(const Duration(seconds: 30));
      
      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');
      
      return _handleResponse(response);
    } catch (e) {
      print('❌ POST Error: $e');
      print('❌ Error type: ${e.runtimeType}');
      throw Exception('Network error: $e');
    }
  }

  // Generic PUT request
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final url = Uri.parse('${AppConfig.apiBaseUrl}$endpoint');
      final response = await http.put(
        url,
        headers: _getHeaders(),
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Generic DELETE request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final url = Uri.parse('${AppConfig.apiBaseUrl}$endpoint');
      final response = await http.delete(url, headers: _getHeaders());
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Handle response
  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final data = json.decode(response.body);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      } else if (response.statusCode == 401) {
        clearToken();
        throw Exception('Unauthorized. Please login again.');
      } else {
        throw Exception(data['message'] ?? 'Request failed');
      }
    } catch (e) {
      print('❌ Response parsing error: $e');
      print('❌ Raw response: ${response.body}');
      rethrow;
    }
  }

  // ========== AUTH ENDPOINTS ==========
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    return await post('/auth/login', {
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    return await post('/auth/register', userData);
  }

  Future<Map<String, dynamic>> getProfile() async {
    return await get('/auth/profile');
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    return await put('/auth/profile', data);
  }

  // ========== FIELD ENDPOINTS ==========
  
  Future<Map<String, dynamic>> getFields() async {
    return await get('/fields');
  }

  Future<Map<String, dynamic>> getField(int fieldId) async {
    return await get('/fields/$fieldId');
  }

  Future<Map<String, dynamic>> createField(Map<String, dynamic> data) async {
    return await post('/fields', data);
  }

  Future<Map<String, dynamic>> updateField(int fieldId, Map<String, dynamic> data) async {
    return await put('/fields/$fieldId', data);
  }

  Future<Map<String, dynamic>> deleteField(int fieldId) async {
    return await delete('/fields/$fieldId');
  }

  // ========== SENSOR ENDPOINTS ==========
  
  Future<Map<String, dynamic>> getFieldSensors(int fieldId) async {
    return await get('/sensors/field/$fieldId');
  }

  Future<Map<String, dynamic>> getSensorReadings(int sensorId) async {
    return await get('/sensors/$sensorId/readings');
  }

  Future<Map<String, dynamic>> getLatestReading(int sensorId) async {
    return await get('/sensors/$sensorId/latest');
  }

  // ========== IRRIGATION ENDPOINTS ==========
  
  Future<Map<String, dynamic>> getIrrigationLogs(int fieldId) async {
    return await get('/irrigation/logs/$fieldId');
  }

  Future<Map<String, dynamic>> startIrrigation(Map<String, dynamic> data) async {
    return await post('/irrigation/start', data);
  }

  Future<Map<String, dynamic>> stopIrrigation(int fieldId) async {
    return await post('/irrigation/stop', {'field_id': fieldId});
  }

  Future<Map<String, dynamic>> getIrrigationSchedules(int fieldId) async {
    return await get('/irrigation/schedules/$fieldId');
  }

  // ========== ALERT ENDPOINTS ==========
  
  Future<Map<String, dynamic>> getAlerts() async {
    return await get('/alerts');
  }

  Future<Map<String, dynamic>> getUnreadCount() async {
    return await get('/alerts/unread-count');
  }

  Future<Map<String, dynamic>> markAsRead(int alertId) async {
    return await put('/alerts/$alertId/read', {});
  }

  Future<Map<String, dynamic>> resolveAlert(int alertId) async {
    return await put('/alerts/$alertId/resolve', {});
  }

  // ========== DASHBOARD ENDPOINTS ==========
  
  Future<Map<String, dynamic>> getDashboardStats() async {
    return await get('/dashboard/stats');
  }

  Future<Map<String, dynamic>> getDashboardActivity() async {
    return await get('/dashboard/activity');
  }

  // ========== RECOMMENDATION ENDPOINTS ==========
  
  Future<Map<String, dynamic>> getRecommendations(int fieldId) async {
    return await get('/recommendations/$fieldId');
  }

  Future<Map<String, dynamic>> acceptRecommendation(int recommendationId) async {
    return await put('/recommendations/$recommendationId/accept', {});
  }
}
