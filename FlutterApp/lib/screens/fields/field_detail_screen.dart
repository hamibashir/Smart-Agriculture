import 'package:flutter/material.dart';
import '../../models/field.dart';
import '../../models/sensor.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';
import 'package:intl/intl.dart';

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
        final sensorsData = response['data'] as List;
        setState(() {
          _sensors = sensorsData.map((json) => Sensor.fromJson(json)).toList();
          _isLoadingSensors = false;
        });
      }
    } catch (e) {
      print('❌ Sensors Error: $e');
      setState(() => _isLoadingSensors = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.field.fieldName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit field
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Sensors'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildSensorsTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Field Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Field Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Area', '${widget.field.areaSize} ${widget.field.areaUnit}'),
                  if (widget.field.soilType != null)
                    _buildInfoRow('Soil Type', widget.field.soilType!),
                  if (widget.field.currentCrop != null)
                    _buildInfoRow('Current Crop', widget.field.currentCrop!),
                  if (widget.field.plantingDate != null)
                    _buildInfoRow(
                      'Planting Date',
                      DateFormat('MMM dd, yyyy').format(widget.field.plantingDate!),
                    ),
                  if (widget.field.expectedHarvestDate != null)
                    _buildInfoRow(
                      'Expected Harvest',
                      DateFormat('MMM dd, yyyy').format(widget.field.expectedHarvestDate!),
                    ),
                  _buildInfoRow(
                    'Status',
                    widget.field.isActive ? 'Active' : 'Inactive',
                    valueColor: widget.field.isActive ? AppTheme.successColor : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Location Card
          if (widget.field.locationLatitude != null && widget.field.locationLongitude != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Latitude', widget.field.locationLatitude!.toStringAsFixed(6)),
                    _buildInfoRow('Longitude', widget.field.locationLongitude!.toStringAsFixed(6)),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Open in maps
                      },
                      icon: const Icon(Icons.map),
                      label: const Text('View on Map'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSensorsTab() {
    if (_isLoadingSensors) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_sensors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sensors_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No sensors installed',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add sensors to monitor this field',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _sensors.length,
      itemBuilder: (context, index) {
        final sensor = _sensors[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: sensor.isActive
                    ? AppTheme.successColor.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.sensors,
                color: sensor.isActive ? AppTheme.successColor : Colors.grey,
              ),
            ),
            title: Text(sensor.deviceId),
            subtitle: Text(sensor.sensorType.replaceAll('_', ' ').toUpperCase()),
            trailing: sensor.batteryLevel != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.battery_std,
                        color: sensor.batteryLevel! > 30
                            ? AppTheme.successColor
                            : AppTheme.warningColor,
                      ),
                      Text('${sensor.batteryLevel!.toInt()}%'),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildHistoryTab() {
    return const Center(
      child: Text('Irrigation and activity history coming soon'),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
          ),
        ],
      ),
    );
  }
}
