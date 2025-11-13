import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/field.dart';
import '../../models/irrigation.dart';
import '../../config/app_theme.dart';
import 'package:intl/intl.dart';

class IrrigationScreen extends StatefulWidget {
  const IrrigationScreen({super.key});

  @override
  State<IrrigationScreen> createState() => _IrrigationScreenState();
}

class _IrrigationScreenState extends State<IrrigationScreen> with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  late TabController _tabController;
  
  List<Field> _fields = [];
  List<IrrigationLog> _logs = [];
  List<IrrigationSchedule> _schedules = [];
  
  Field? _selectedField;
  bool _isLoading = true;
  bool _isIrrigating = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadFields();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadFields() async {
    try {
      final response = await _apiService.getFields();
      if (response['success'] == true) {
        final fieldsData = response['data'] as List;
        setState(() {
          _fields = fieldsData.map((json) => Field.fromJson(json)).toList();
          if (_fields.isNotEmpty) {
            _selectedField = _fields.first;
            _loadFieldData();
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Load Fields Error: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadFieldData() async {
    if (_selectedField == null) return;

    try {
      // Load irrigation logs
      final logsResponse = await _apiService.getIrrigationLogs(_selectedField!.fieldId);
      if (logsResponse['success'] == true) {
        final logsData = logsResponse['data'] as List;
        setState(() {
          _logs = logsData.map((json) => IrrigationLog.fromJson(json)).toList();
        });
      }

      // Load schedules
      final schedulesResponse = await _apiService.getIrrigationSchedules(_selectedField!.fieldId);
      if (schedulesResponse['success'] == true) {
        final schedulesData = schedulesResponse['data'] as List;
        setState(() {
          _schedules = schedulesData.map((json) => IrrigationSchedule.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('❌ Error loading field data: $e');
    }
  }

  Future<void> _startIrrigation() async {
    if (_selectedField == null) return;

    setState(() => _isIrrigating = true);

    try {
      final response = await _apiService.startIrrigation({
        'field_id': _selectedField!.fieldId,
        'irrigation_type': 'manual',
        'duration_minutes': 30,
      });

      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Irrigation started successfully'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        _loadFieldData();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to start irrigation: $e'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      setState(() => _isIrrigating = false);
    }
  }

  Future<void> _stopIrrigation() async {
    if (_selectedField == null) return;

    try {
      final response = await _apiService.stopIrrigation(_selectedField!.fieldId);

      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Irrigation stopped'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        _loadFieldData();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to stop irrigation: $e'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irrigation Control'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Control'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fields.isEmpty
              ? _buildEmptyState()
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildControlTab(),
                    _buildHistoryTab(),
                  ],
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.water_drop_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No fields available',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Add a field to start irrigation',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Field Selector
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Field',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<Field>(
                    value: _selectedField,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.grass),
                    ),
                    items: _fields.map((field) {
                      return DropdownMenuItem(
                        value: field,
                        child: Text(field.fieldName),
                      );
                    }).toList(),
                    onChanged: (field) {
                      setState(() {
                        _selectedField = field;
                        _loadFieldData();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Manual Control
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.infoColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.water_drop,
                          color: AppTheme.infoColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Manual Control',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Start or stop irrigation manually for the selected field.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isIrrigating ? null : _startIrrigation,
                          icon: _isIrrigating
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Icon(Icons.play_arrow),
                          label: const Text('Start Irrigation'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _stopIrrigation,
                          icon: const Icon(Icons.stop),
                          label: const Text('Stop'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            foregroundColor: AppTheme.errorColor,
                            side: const BorderSide(color: AppTheme.errorColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Schedules
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Schedules',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Add schedule
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_schedules.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'No schedules configured',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                        ),
                      ),
                    )
                  else
                    ..._schedules.map((schedule) => _buildScheduleCard(schedule)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    if (_logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No irrigation history',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _logs.length,
      itemBuilder: (context, index) {
        final log = _logs[index];
        return _buildLogCard(log);
      },
    );
  }

  Widget _buildScheduleCard(IrrigationSchedule schedule) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          Icons.schedule,
          color: schedule.isActive ? AppTheme.primaryGreen : Colors.grey,
        ),
        title: Text(schedule.scheduleName),
        subtitle: Text(
          '${schedule.timeOfDay} • ${schedule.durationMinutes} min • ${schedule.frequency}',
        ),
        trailing: Switch(
          value: schedule.isActive,
          onChanged: (value) {
            // Toggle schedule
          },
        ),
      ),
    );
  }

  Widget _buildLogCard(IrrigationLog log) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.infoColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    log.irrigationType == 'automatic'
                        ? Icons.auto_mode
                        : Icons.touch_app,
                    color: AppTheme.infoColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        log.irrigationType.toUpperCase(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy • hh:mm a').format(log.startTime),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: log.pumpStatus == 'on'
                        ? AppTheme.successColor.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    log.pumpStatus.toUpperCase(),
                    style: TextStyle(
                      color: log.pumpStatus == 'on' ? AppTheme.successColor : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (log.waterUsedLiters != null || log.durationMinutes != null) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (log.waterUsedLiters != null) ...[
                    Expanded(
                      child: _buildInfoItem(
                        Icons.water_drop,
                        'Water Used',
                        '${log.waterUsedLiters!.toStringAsFixed(1)}L',
                      ),
                    ),
                  ],
                  if (log.durationMinutes != null) ...[
                    Expanded(
                      child: _buildInfoItem(
                        Icons.timer,
                        'Duration',
                        '${log.durationMinutes} min',
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.textSecondary),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
