import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/sensor.dart';
import '../../services/api_service.dart';
import '../../widgets/loading_shimmer.dart';

class TestFieldScreen extends StatefulWidget {
  static const routeName = '/test-field';

  const TestFieldScreen({Key? key}) : super(key: key);

  @override
  _TestFieldScreenState createState() => _TestFieldScreenState();
}

class _TestFieldScreenState extends State<TestFieldScreen> {
  final ApiService _apiService = ApiService();
  Sensor? _sensor;
  List<SensorReading> _readings = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSensorData();
  }

  Future<void> _loadSensorData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Get all sensors for field_id 10
      final sensorsResponse = await _apiService.getFieldSensors(10);
      if (sensorsResponse['success'] == true) {
        final sensors = (sensorsResponse['data'] as List)
            .map((sensor) => Sensor.fromJson(sensor))
            .toList();
        
        if (sensors.isEmpty) {
          throw Exception('No sensors found for this field');
        }
        
        // Try to find sensor with ID 14, otherwise use the first available sensor
        final testSensor = sensors.firstWhere(
          (sensor) => sensor.sensorId == 14,
          orElse: () => sensors.first,
        );

        // Get sensor readings for the selected sensor
        final readingsResponse = await _apiService.getSensorReadings(testSensor.sensorId);
        
        if (readingsResponse['success'] == true) {
          setState(() {
            _sensor = testSensor;
            _readings = (readingsResponse['data'] as List)
                .map((reading) => SensorReading.fromJson(reading))
                .toList();
            _isLoading = false;
          });
        } else {
          throw Exception('Failed to load sensor readings');
        }
      } else {
        throw Exception('Failed to load sensor data');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Field Sensor Data'),
      ),
      body: _isLoading
          ? const LoadingShimmer()
          : _error != null
              ? Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.sensors_off, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          _error!,
                          style: const TextStyle(fontSize: 16, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Field ID: 10',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _loadSensorData,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : _buildSensorData(),
    );
  }

  Widget _buildSensorData() {
    if (_sensor == null) {
      return const Center(child: Text('No sensor data available'));
    }

    final latestReading = _readings.isNotEmpty ? _readings.first : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sensor #${_sensor!.sensorId} - ${_sensor!.sensorType}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('Device ID: ${_sensor!.deviceId}'),
                  if (_sensor!.sensorModel != null)
                    Text('Model: ${_sensor!.sensorModel}'),
                  if (_sensor!.batteryLevel != null)
                    Text('Battery: ${_sensor!.batteryLevel!.toStringAsFixed(1)}%'),
                  if (_sensor!.locationDescription != null)
                    Text('Location: ${_sensor!.locationDescription}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (latestReading != null) ..._buildReadingCards(latestReading),
          const SizedBox(height: 16),
          _buildReadingsHistory(),
        ],
      ),
    );
  }

  List<Widget> _buildReadingCards(SensorReading reading) {
    return [
      const Text(
        'Current Reading',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          if (reading.temperature != null)
            _buildMetricCard(
              'Temperature',
              '${reading.temperature!.toStringAsFixed(1)}°C',
              Icons.thermostat,
              Colors.orange,
            ),
          if (reading.humidity != null)
            _buildMetricCard(
              'Humidity',
              '${reading.humidity!.toStringAsFixed(1)}%',
              Icons.water_drop,
              Colors.blue,
            ),
          if (reading.soilMoisture != null)
            _buildMetricCard(
              'Soil Moisture',
              '${reading.soilMoisture!.toStringAsFixed(1)}%',
              Icons.grass,
              Colors.green,
            ),
          if (reading.lightIntensity != null)
            _buildMetricCard(
              'Light',
              '${reading.lightIntensity!.toStringAsFixed(1)} lx',
              Icons.lightbulb_outline,
              Colors.amber,
            ),
        ],
      ),
    ];
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingsHistory() {
    if (_readings.isEmpty) {
      return const Center(child: Text('No historical data available'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Readings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: _readings.length,
              itemBuilder: (context, index) {
                final reading = _readings[index];
                return ListTile(
                  title: Text(
                    '${reading.readingTimestamp.toLocal().toString().substring(0, 16)}',
                  ),
                  subtitle: Text(
                    'Temp: ${reading.temperature?.toStringAsFixed(1) ?? 'N/A'}°C • '
                    'Humidity: ${reading.humidity?.toStringAsFixed(1) ?? 'N/A'}%\n'
                    'Soil: ${reading.soilMoisture?.toStringAsFixed(1) ?? 'N/A'}% • '
                    'Light: ${reading.lightIntensity?.toStringAsFixed(1) ?? 'N/A'} lx',
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
