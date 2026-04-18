import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FieldSelectionProvider with ChangeNotifier {
  static const _selectedFieldKey = 'selected_field_id';

  int? _selectedFieldId;
  bool _isInitialized = false;

  int? get selectedFieldId => _selectedFieldId;
  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedFieldId = prefs.getInt(_selectedFieldKey);
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> setSelectedFieldId(int? fieldId) async {
    if (_selectedFieldId == fieldId) return;

    _selectedFieldId = fieldId;

    final prefs = await SharedPreferences.getInstance();
    if (fieldId == null) {
      await prefs.remove(_selectedFieldKey);
    } else {
      await prefs.setInt(_selectedFieldKey, fieldId);
    }

    notifyListeners();
  }

  Future<void> clear() => setSelectedFieldId(null);
}
