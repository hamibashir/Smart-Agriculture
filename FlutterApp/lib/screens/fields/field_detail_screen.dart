import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/field.dart';
import '../../models/sensor.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';

class FieldDetailScreen extends StatefulWidget {
  final Field field;

  const FieldDetailScreen({super.key, required this.field});

  @override
  State<FieldDetailScreen> createState() => _FieldDetailScreenState();
}

class _FieldDetailScreenState extends State<FieldDetailScreen> with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  late TabController _tabController;
  List<Sensor> _sensors = [];
  bool _isLoadingSensors = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSensors();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadSensors() async {
    try {
      final response = await _apiService.getFieldSensors(widget.field.fieldId);
      if (response['success'] == true) {
        setState(() {
          _sensors = (response['data'] as List).map((json) => Sensor.fromJson(json)).toList();
          _isLoadingSensors = false;
        });
      }
    } catch (_) {
      setState(() => _isLoadingSensors = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.field.fieldName),
        actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Overview'), Tab(text: 'Sensors'), Tab(text: 'History')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _OverviewTab(field: widget.field),
          _SensorsTab(sensors: _sensors, isLoading: _isLoadingSensors),
          const _HistoryTab(),
        ],
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.field});

  final Field field;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Field Information', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  _InfoRow('Area', '${field.areaSize} ${field.areaUnit}'),
                  if (field.soilType != null) _InfoRow('Soil Type', field.soilType!),
                  if (field.currentCrop != null) _InfoRow('Current Crop', field.currentCrop!),
                  if (field.plantingDate != null) _InfoRow('Planting Date', DateFormat('MMM dd, yyyy').format(field.plantingDate!)),
                  if (field.expectedHarvestDate != null) _InfoRow('Expected Harvest', DateFormat('MMM dd, yyyy').format(field.expectedHarvestDate!)),
                  _InfoRow('Status', field.isActive ? 'Active' : 'Inactive', valueColor: field.isActive ? AppTheme.successColor : Colors.grey),
                ],
              ),
            ),
          ),
          if (field.locationLatitude != null && field.locationLongitude != null) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    _InfoRow('Latitude', field.locationLatitude!.toStringAsFixed(6)),
                    _InfoRow('Longitude', field.locationLongitude!.toStringAsFixed(6)),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.map), label: const Text('View on Map')),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SensorsTab extends StatelessWidget {
  const _SensorsTab({required this.sensors, required this.isLoading});

  final List<Sensor> sensors;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    if (sensors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sensors_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('No sensors installed', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Add sensors to monitor this field', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sensors.length,
      itemBuilder: (_, index) => _SensorCard(sensor: sensors[index]),
    );
  }
}

class _SensorCard extends StatelessWidget {
  const _SensorCard({required this.sensor});

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: sensor.isActive ? AppTheme.successColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.sensors, color: sensor.isActive ? AppTheme.successColor : Colors.grey),
        ),
        title: Text(sensor.deviceId),
        subtitle: Text(sensor.sensorType.replaceAll('_', ' ').toUpperCase()),
        trailing: sensor.batteryLevel != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.battery_std, color: sensor.batteryLevel! > 30 ? AppTheme.successColor : AppTheme.warningColor),
                  Text('${sensor.batteryLevel!.toInt()}%'),
                ],
              )
            : null,
      ),
    );
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Irrigation and activity history coming soon'));
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value, {this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
          Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: valueColor)),
        ],
      ),
    );
  }
}