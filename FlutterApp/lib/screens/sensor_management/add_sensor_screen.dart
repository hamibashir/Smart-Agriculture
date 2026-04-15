import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';
import '../../models/field.dart';

class AddSensorScreen extends StatefulWidget {
  const AddSensorScreen({super.key});

  @override
  State<AddSensorScreen> createState() => _AddSensorScreenState();
}

class _AddSensorScreenState extends State<AddSensorScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  final _deviceIdController = TextEditingController();
  final _sensorModelController = TextEditingController();
  final _locationController = TextEditingController();

  String _sensorType = 'combined';
  int? _selectedFieldId;
  List<Field> _fields = [];
  bool _isLoading = false;
  bool _isLoadingFields = true;

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  Future<void> _loadFields() async {
    try {
      final response = await _apiService.get('/fields');
      if (response['success'] == true) {
        setState(() {
          _fields = (response['data'] as List).map((f) => Field.fromJson(f)).toList();
          _isLoadingFields = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load fields. Please add a field first.')),
        );
      }
      setState(() => _isLoadingFields = false);
    }
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    _sensorModelController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedFieldId == null) {
      _showSnackBar('Please select a field first', AppTheme.errorColor);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await _apiService.createSensor({
        'field_id': _selectedFieldId,
        'sensor_type': _sensorType,
        'device_id': _deviceIdController.text.trim(),
        'sensor_model': _sensorModelController.text.trim().isEmpty ? null : _sensorModelController.text.trim(),
        'location_description': _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
        'installation_date': DateTime.now().toIso8601String().split('T')[0], // YYYY-MM-DD format
      });

      if (response['success'] == true) {
        if (!mounted) return;
        _showSnackBar('Hardware registered successfully', AppTheme.successColor);
        Navigator.pop(context, true);
      }
    } catch (e) {
      _showSnackBar(e.toString().replaceAll('Exception: ', ''), AppTheme.errorColor);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register New Hardware')),
      body: _isLoadingFields 
          ? const Center(child: CircularProgressIndicator())
          : _fields.isEmpty
              ? _buildEmptyFieldsState()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Register Device',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Enter the unique MAC address (Device ID) attached to your ESP32 board to link it to your account.',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 24),

                        // Field Selection
                        DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Assign to Field *',
                            prefixIcon: Icon(Icons.landscape),
                          ),
                          value: _selectedFieldId,
                          items: _fields.map((f) => DropdownMenuItem(value: f.fieldId, child: Text(f.fieldName))).toList(),
                          onChanged: (val) => setState(() => _selectedFieldId = val),
                          validator: (val) => val == null ? 'Please choose a field' : null,
                        ),
                        const SizedBox(height: 16),

                        // Device ID
                        TextFormField(
                          controller: _deviceIdController,
                          decoration: const InputDecoration(
                            labelText: 'Device ID (MAC Address) *',
                            hintText: 'e.g., A1:B2:C3:D4:E5:F6',
                            prefixIcon: Icon(Icons.memory),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Device ID is required' : null,
                        ),
                        const SizedBox(height: 16),
                        
                        // Sensor Type
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Module Type',
                            prefixIcon: Icon(Icons.category),
                          ),
                          value: _sensorType,
                          items: const [
                            DropdownMenuItem(value: 'combined', child: Text('Complete Smart Node (Combined)')),
                            DropdownMenuItem(value: 'soil_moisture', child: Text('Soil Moisture Only')),
                            DropdownMenuItem(value: 'temperature', child: Text('Temperature & Humidity')),
                          ],
                          onChanged: (val) => setState(() => _sensorType = val!),
                        ),
                        const SizedBox(height: 16),

                        // Optional Details
                        TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location in Field (Optional)',
                            hintText: 'e.g., North-West Corner',
                            prefixIcon: Icon(Icons.place),
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                          child: _isLoading
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                              : const Text('Register Hardware', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildEmptyFieldsState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.landscape_outlined, size: 64, color: AppTheme.textSecondary),
            const SizedBox(height: 16),
            const Text(
              'No Fields Found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'You need to create a field first before you can register physical sensors to it.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
