import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../config/app_config.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  User? _user;
  bool _isAuthenticated = false;
  bool _isLoading = true;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  // Initialize auth state
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.init();
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(AppConfig.userKey);

      if (userData != null) {
        _user = User.fromJson(json.decode(userData));
        _isAuthenticated = true;
      }
    } catch (e) {
      print('Auth init error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    try {
      print('🔐 Attempting login for: $email');
      print('🌐 API URL: ${AppConfig.apiBaseUrl}');
      
      final response = await _apiService.login(email, password);
      print('📥 Login response: $response');
      
      if (response['success'] == true) {
        final token = response['token'];
        final userData = response['user'];

        await _apiService.setToken(token);
        _user = User.fromJson(userData);
        _isAuthenticated = true;

        // Save user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConfig.userKey, json.encode(userData));

        notifyListeners();
        print('✅ Login successful');
        return true;
      }
      print('❌ Login failed: ${response['message']}');
      return false;
    } catch (e) {
      print('❌ Login error: $e');
      return false;
    }
  }

  // Register
  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.register(userData);
      
      if (response['success'] == true) {
        final token = response['token'];
        final user = response['user'];

        await _apiService.setToken(token);
        _user = User.fromJson(user);
        _isAuthenticated = true;

        // Save user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConfig.userKey, json.encode(user));

        notifyListeners();
        return {'success': true};
      }
      return {'success': false, 'message': response['message']};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Logout
  Future<void> logout() async {
    await _apiService.clearToken();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Update profile
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.updateProfile(data);
      
      if (response['success'] == true) {
        _user = User.fromJson(response['data']);
        
        // Update stored user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConfig.userKey, json.encode(response['data']));
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }
}
