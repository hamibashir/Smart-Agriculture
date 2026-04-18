import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../config/app_config.dart';
import 'field_selection_provider.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _user;
  bool _isAuthenticated = false;
  bool _isLoading = true;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    try {
      await _apiService.init();
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(AppConfig.userKey);

      if (userData != null) {
        _user = User.fromJson(json.decode(userData));
        _isAuthenticated = true;
      }
    } catch (_) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      if (response['success'] != true) return false;

      await _setAuthData(response['token'], response['user']);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.register(userData);
      if (response['success'] != true) return {'success': false, 'message': response['message']};

      await _setAuthData(response['token'], response['user']);
      return const {'success': true};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<void> logout() async {
    await _apiService.clearToken();
    _user = null;
    _isAuthenticated = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.userKey);

    notifyListeners();
  }

  Future<void> logoutAndClearFieldSelection(FieldSelectionProvider fieldSelectionProvider) async {
    await logout();
    await fieldSelectionProvider.clear();
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.updateProfile(data);
      if (response['success'] != true) return false;

      _user = User.fromJson(response['data']);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConfig.userKey, json.encode(response['data']));

      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _setAuthData(String token, Map<String, dynamic> userData) async {
    await _apiService.setToken(token);
    _user = User.fromJson(userData);
    _isAuthenticated = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.userKey, json.encode(userData));

    notifyListeners();
  }
}
