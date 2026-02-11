import 'package:flutter/material.dart';
import '../../models/sensor.dart';
import '../../models/field.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';

class SensorBindingScreen extends StatefulWidget {
  const SensorBindingScreen({super.key});

  @override
  State<SensorBindingScreen> createState() => _SensorBindingScreenState();
}

class _SensorBindingScreenState extends State<SensorBindingScreen> {
  final ApiService _apiService = ApiService();
  List<Sensor> _sensors = [];
  List<Field> _fields = [];
  bool _isLoading = true;
  String? _error;
  int? _selectedSensorId;
  int? _selectedFieldId;
  bool _isBinding = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final fieldsResponse = await _apiService.get('/fields');
      
      if (fieldsResponse['success'] == true) {
        final fields = (fieldsResponse['data'] as List).map((field) => Field.fromJson(field)).toList();
        final allSensors = <Sensor>[];
        
        for (final field in fields) {
          try {
            final sensorsResponse = await _apiService.getFieldSensors(field.fieldId);
            if (sensorsResponse['success'] == true) {
              allSensors.addAll((sensorsResponse['data'] as List).map((sensor) => Sensor.fromJson(sensor)));
            }
          } catch (_) {}
        }
        
        setState(() {
          _sensors = allSensors;
          _fields = fields;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load fields');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _bindSensorToField() async {
    if (_selectedSensorId == null || _selectedFieldId == null) {
      _showSnackBar('Please select both sensor and field');
      return;
    }

    setState(() => _isBinding = true);

    try {
      final sensor = _sensors.firstWhere((s) => s.sensorId == _selectedSensorId, orElse: () => throw Exception('Selected sensor not found'));

      if (sensor.fieldId == _selectedFieldId) {
        _showSnackBar('Sensor is already bound to this field');
        return;
      }

      final response = await _apiService.bindSensorToField(_selectedSensorId!, _selectedFieldId!);

      if (response['success'] == true) {
        _showSnackBar('Sensor successfully bound to field');
        await _loadData();
      } else {
        throw Exception(response['message'] ?? 'Failed to bind sensor to field');
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    } finally {
      setState(() => _isBinding = false);
    }
  }

  void _showSnackBar(String message) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bind Sensor to Field'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData)],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(error: _error!, onRetry: _loadData)
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _BindingForm(
                        sensors: _sensors,
                        fields: _fields,
                        selectedSensorId: _selectedSensorId,
                        selectedFieldId: _selectedFieldId,
                        isBinding: _isBinding,
                        onSensorChanged: (id) => setState(() => _selectedSensorId = id),
                        onFieldChanged: (id) => setState(() => _selectedFieldId = id),
                        onBind: _bindSensorToField,
                      ),
                      const SizedBox(height: 24),
                      const Text('Current Sensor Bindings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      if (_sensors.isEmpty)
                        const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No sensors found')))
                      else
                        ..._sensors.map((sensor) => _SensorBindingCard(
                              sensor: sensor,
                              field: _fields.firstWhere((f) => f.fieldId == sensor.fieldId, orElse: () => _createUnassignedField()),
                              onTap: () {
                                setState(() {
                                  _selectedSensorId = sensor.sensorId;
                                  _selectedFieldId = sensor.fieldId > 0 ? sensor.fieldId : null;
                                });
                                PrimaryScrollController.of(context).animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                              },
                            )),
                    ],
                  ),
                ),
    );
  }

  Field _createUnassignedField() => Field(
        fieldId: -1,
        userId: -1,
        fieldName: 'Unassigned',
        locationLatitude: 0,
        locationLongitude: 0,
        areaSize: 0,
        areaUnit: 'acres',
        isActive: false,
        createdAt: DateTime.now(),
      );
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppTheme.errorColor),
          const SizedBox(height: 16),
          Text('Error: $error', style: const TextStyle(color: AppTheme.errorColor), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _BindingForm extends StatelessWidget {
  const _BindingForm({
    required this.sensors,
    required this.fields,
    required this.selectedSensorId,
    required this.selectedFieldId,
    required this.isBinding,
    required this.onSensorChanged,
    required this.onFieldChanged,
    required this.onBind,
  });

  final List<Sensor> sensors;
  final List<Field> fields;
  final int? selectedSensorId;
  final int? selectedFieldId;
  final bool isBinding;
  final ValueChanged<int?> onSensorChanged;
  final ValueChanged<int?> onFieldChanged;
  final VoidCallback onBind;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bind Sensor to Field', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Select Sensor'),
              key: ValueKey(selectedSensorId),
              initialValue: selectedSensorId,
              items: sensors.map((s) => DropdownMenuItem(value: s.sensorId, child: Text('${s.sensorType} (${s.deviceId})', overflow: TextOverflow.ellipsis))).toList(),
              onChanged: onSensorChanged,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Select Field'),
              key: ValueKey(selectedFieldId),
              initialValue: selectedFieldId,
              items: fields.map((f) => DropdownMenuItem(value: f.fieldId, child: Text(f.fieldName, overflow: TextOverflow.ellipsis))).toList(),
              onChanged: onFieldChanged,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isBinding ? null : onBind,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: isBinding
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                  : const Text('Bind Sensor to Field'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SensorBindingCard extends StatelessWidget {
  const _SensorBindingCard({required this.sensor, required this.field, required this.onTap});

  final Sensor sensor;
  final Field field;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(sensor.isActive ? Icons.sensors : Icons.sensors_off, color: sensor.isActive ? AppTheme.successColor : Colors.grey),
        title: Text('${sensor.sensorType} (ID: ${sensor.sensorId})'),
        subtitle: Text('Device: ${sensor.deviceId}\nField: ${field.fieldName}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
