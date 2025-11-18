import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/sensor.dart';
import '../../models/field.dart';
import '../../services/api_service.dart';
import '../../widgets/loading_shimmer.dart';

class SensorBindingScreen extends StatefulWidget {
  static const routeName = '/sensor-binding';

  const SensorBindingScreen({Key? key}) : super(key: key);

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
      // Load all fields first
      final fieldsResponse = await _apiService.get('/fields');
      
      if (fieldsResponse['success'] == true) {
        final fields = (fieldsResponse['data'] as List)
            .map((field) => Field.fromJson(field))
            .toList();
        
        // For each field, load its sensors
        final allSensors = <Sensor>[];
        
        for (final field in fields) {
          try {
            final sensorsResponse = await _apiService.getFieldSensors(field.fieldId);
            if (sensorsResponse['success'] == true) {
              final fieldSensors = (sensorsResponse['data'] as List)
                  .map((sensor) => Sensor.fromJson(sensor))
                  .toList();
              allSensors.addAll(fieldSensors);
            }
          } catch (e) {
            // Skip if we can't load sensors for a field
            debugPrint('Error loading sensors for field ${field.fieldId}: $e');
          }
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both sensor and field')),
      );
      return;
    }

    setState(() {
      _isBinding = true;
    });

    try {
      // First, get the current sensor to check if it's already bound to a field
      final sensor = _sensors.firstWhere(
        (s) => s.sensorId == _selectedSensorId,
        orElse: () => throw Exception('Selected sensor not found'),
      );

      // If the sensor is already bound to the selected field, do nothing
      if (sensor.fieldId == _selectedFieldId) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sensor is already bound to this field')),
        );
        return;
      }

      // Use the bindSensorToField method from the API service
      final response = await _apiService.bindSensorToField(
        _selectedSensorId!,
        _selectedFieldId!,
      );

      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sensor successfully bound to field')),
        );
        // Reload data to reflect changes
        await _loadData();
      } else {
        throw Exception(response['message'] ?? 'Failed to bind sensor to field');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isBinding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bind Sensor to Field'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingShimmer()
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: $_error',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Bind Sensor to Field',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Sensor Dropdown
                              DropdownButtonFormField<int>(
                                decoration: const InputDecoration(
                                  labelText: 'Select Sensor',
                                  border: OutlineInputBorder(),
                                ),
                                value: _selectedSensorId,
                                items: _sensors.map((sensor) {
                                  return DropdownMenuItem<int>(
                                    value: sensor.sensorId,
                                    child: Text(
                                      '${sensor.sensorType} (ID: ${sensor.sensorId} - ${sensor.deviceId})',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSensorId = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              // Field Dropdown
                              DropdownButtonFormField<int>(
                                decoration: const InputDecoration(
                                  labelText: 'Select Field',
                                  border: OutlineInputBorder(),
                                ),
                                value: _selectedFieldId,
                                items: _fields.map((field) {
                                  return DropdownMenuItem<int>(
                                    value: field.fieldId,
                                    child: Text(
                                      '${field.fieldName} (ID: ${field.fieldId} - ${field.locationLatitude}, ${field.locationLongitude})',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedFieldId = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                              // Bind Button
                              ElevatedButton(
                                onPressed: _isBinding ? null : _bindSensorToField,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: _isBinding
                                    ? const CircularProgressIndicator()
                                    : const Text('Bind Sensor to Field'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // List of current sensor bindings
                      const Text(
                        'Current Sensor Bindings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ..._buildSensorBindingsList(),
                    ],
                  ),
                ),
    );
  }

  List<Widget> _buildSensorBindingsList() {
    if (_sensors.isEmpty) {
      return [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No sensors found'),
          ),
        ),
      ];
    }

    return _sensors.map((sensor) {
      final field = _fields.firstWhere(
        (f) => f.fieldId == sensor.fieldId,
        orElse: () => Field(
          fieldId: -1,
          userId: -1,
          fieldName: 'Unassigned',
          locationLatitude: 0,
          locationLongitude: 0,
          areaSize: 0,
          areaUnit: 'acres',
          isActive: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      return Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: Icon(
            sensor.isActive ? Icons.sensors : Icons.sensors_off,
            color: sensor.isActive ? Colors.green : Colors.grey,
          ),
          title: Text('${sensor.sensorType} (ID: ${sensor.sensorId})'),
          subtitle: Text(
            'Device: ${sensor.deviceId}\n'
            'Field: ${field.fieldName} (ID: ${field.fieldId})',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            setState(() {
              _selectedSensorId = sensor.sensorId;
              _selectedFieldId = sensor.fieldId > 0 ? sensor.fieldId : null;
            });
            // Scroll to top to show the form with selected values
            PrimaryScrollController.of(context)?.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      );
    }).toList();
  }
}
