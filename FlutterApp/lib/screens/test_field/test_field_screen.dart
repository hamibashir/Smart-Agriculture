import 'package:flutter/material.dart';
import 'dart:async';
import '../../models/sensor.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';
import 'package:intl/intl.dart';

class TestFieldScreen extends StatefulWidget {
  const TestFieldScreen({super.key});

  @override
  State<TestFieldScreen> createState() => _TestFieldScreenState();
}

class _TestFieldScreenState extends State<TestFieldScreen> {
  final ApiService _apiService = ApiService();
  Sensor? _sensor;
  List<SensorReading> _readings = [];
  bool _isLoading = true;
  String? _error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadSensorData();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => _loadSensorData(isRefresh: true));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadSensorData({bool isRefresh = false}) async {
    if (!isRefresh) setState(() => _isLoading = true);

    try {
      final sensorsResponse = await _apiService.getFieldSensors(6);
      if (sensorsResponse['success'] == true) {
        final sensors = (sensorsResponse['data'] as List).map((sensor) => Sensor.fromJson(sensor)).toList();
        
        if (sensors.isEmpty) throw Exception('No sensors found for this field');
        
        final testSensor = sensors.firstWhere((s) => s.sensorId == 14, orElse: () => sensors.first);
        final readingsResponse = await _apiService.getSensorReadings(testSensor.sensorId);
        
        if (readingsResponse['success'] == true) {
          setState(() {
            _sensor = testSensor;
            _readings = (readingsResponse['data'] as List).map((r) => SensorReading.fromJson(r)).toList();
            _isLoading = false;
            _error = null;
          });
        } else {
          throw Exception('Failed to load sensor readings');
        }
      } else {
        throw Exception('Failed to load sensor data');
      }
    } catch (e) {
      if (!isRefresh) setState(() => _error = e.toString());
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Field Sensor Data'),
        actions: [
          if (!_isLoading && _error == null) const _LiveIndicator(),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(error: _error!, onRetry: _loadSensorData)
              : _sensor == null
                  ? const Center(child: Text('No sensor data available'))
                  : _SensorDataView(sensor: _sensor!, readings: _readings),
    );
  }
}

class _LiveIndicator extends StatelessWidget {
  const _LiveIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: const Row(
        children: [
          Icon(Icons.circle, size: 8, color: Colors.greenAccent),
          SizedBox(width: 6),
          Text('LIVE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sensors_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(error, style: const TextStyle(fontSize: 16, color: AppTheme.errorColor), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Field ID: 6', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 24),
            ElevatedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class _SensorDataView extends StatelessWidget {
  const _SensorDataView({required this.sensor, required this.readings});

  final Sensor sensor;
  final List<SensorReading> readings;

  @override
  Widget build(BuildContext context) {
    final latestReading = readings.isNotEmpty ? readings.first : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SensorInfoCard(sensor: sensor),
          const SizedBox(height: 16),
          if (latestReading != null) ...[
            const Text('Current Reading', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _MetricsGrid(reading: latestReading),
            const SizedBox(height: 16),
          ],
          _ReadingsHistory(readings: readings),
        ],
      ),
    );
  }
}

class _SensorInfoCard extends StatelessWidget {
  const _SensorInfoCard({required this.sensor});

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sensor #${sensor.sensorId} - ${sensor.sensorType}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Device ID: ${sensor.deviceId}'),
            if (sensor.sensorModel != null) Text('Model: ${sensor.sensorModel}'),
            if (sensor.batteryLevel != null) Text('Battery: ${sensor.batteryLevel!.toStringAsFixed(1)}%'),
            if (sensor.locationDescription != null) Text('Location: ${sensor.locationDescription}'),
          ],
        ),
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.reading});

  final SensorReading reading;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        if (reading.temperature != null) _MetricCard('Temperature', '${reading.temperature!.toStringAsFixed(1)}°C', Icons.thermostat, Colors.orange),
        if (reading.humidity != null) _MetricCard('Humidity', '${reading.humidity!.toStringAsFixed(1)}%', Icons.water_drop, Colors.blue),
        if (reading.soilMoisture != null) _MetricCard('Soil Moisture', '${reading.soilMoisture!.toStringAsFixed(1)}%', Icons.grass, Colors.green),
        if (reading.lightIntensity != null) _MetricCard('Light', '${reading.lightIntensity!.toStringAsFixed(1)} lx', Icons.lightbulb_outline, Colors.amber),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard(this.title, this.value, this.icon, this.color);

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _ReadingsHistory extends StatelessWidget {
  const _ReadingsHistory({required this.readings});

  final List<SensorReading> readings;

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) return const Center(child: Text('No historical data available'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Readings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Card(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: readings.length,
              itemBuilder: (_, index) {
                final r = readings[index];
                return ListTile(
                  title: Text(DateFormat('MMM dd, yyyy • HH:mm').format(r.timestamp)),
                  subtitle: Text(
                    'Temp: ${r.temperature?.toStringAsFixed(1) ?? 'N/A'}°C • Humidity: ${r.humidity?.toStringAsFixed(1) ?? 'N/A'}%\n'
                    'Soil: ${r.soilMoisture?.toStringAsFixed(1) ?? 'N/A'}% • Light: ${r.lightIntensity?.toStringAsFixed(1) ?? 'N/A'} lx',
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
