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
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadFieldData() async {
    if (_selectedField == null) return;

    try {
      final logsResponse = await _apiService.getIrrigationLogs(_selectedField!.fieldId);
      if (logsResponse['success'] == true) {
        final logsData = logsResponse['data'] as List;
        setState(() {
          _logs = logsData.map((json) => IrrigationLog.fromJson(json)).toList();
        });
      }

      final schedulesResponse = await _apiService.getIrrigationSchedules(_selectedField!.fieldId);
      if (schedulesResponse['success'] == true) {
        final schedulesData = schedulesResponse['data'] as List;
        setState(() {
          _schedules = schedulesData.map((json) => IrrigationSchedule.fromJson(json)).toList();
        });
      }
    } catch (e) {
      debugPrint('Error loading field data: $e');
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

      if (response['success'] == true && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Irrigation started'), backgroundColor: AppTheme.successColor),
        );
        _loadFieldData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to start irrigation'), backgroundColor: AppTheme.errorColor),
        );
      }
    } finally {
      setState(() => _isIrrigating = false);
    }
  }

  Future<void> _stopIrrigation() async {
    if (_selectedField == null) return;

    try {
      final response = await _apiService.stopIrrigation(_selectedField!.fieldId);
      if (response['success'] == true && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Irrigation stopped'), backgroundColor: AppTheme.successColor),
        );
        _loadFieldData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to stop irrigation'), backgroundColor: AppTheme.errorColor),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Irrigation'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Control'), Tab(text: 'History')],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fields.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.water_drop_outlined, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text('No fields available', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                )
              : TabBarView(
                  controller: _tabController,
                  children: [_buildControlTab(), _buildHistoryTab()],
                ),
    );
  }

  Widget _buildControlTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Field', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                DropdownButtonFormField<Field>(
                  value: _selectedField,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.grass)),
                  items: _fields.map((field) => DropdownMenuItem(value: field, child: Text(field.fieldName))).toList(),
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
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Manual Control', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isIrrigating ? null : _startIrrigation,
                        icon: _isIrrigating ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.play_arrow),
                        label: const Text('Start'),
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _stopIrrigation,
                        icon: const Icon(Icons.stop),
                        label: const Text('Stop'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
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
            const Text('No irrigation history', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _logs.length,
      itemBuilder: (context, index) {
        final log = _logs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(log.irrigationType == 'automatic' ? Icons.auto_mode : Icons.touch_app, color: AppTheme.infoColor, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(log.irrigationType.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        Text(DateFormat('MMM dd, yyyy • hh:mm a').format(log.startTime), style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: log.pumpStatus == 'on' ? AppTheme.successColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      log.pumpStatus.toUpperCase(),
                      style: TextStyle(
                        color: log.pumpStatus == 'on' ? AppTheme.successColor : Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (log.waterUsedLiters != null || log.durationMinutes != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (log.waterUsedLiters != null)
                      Expanded(child: Text('💧 ${log.waterUsedLiters!.toStringAsFixed(1)}L', style: const TextStyle(fontSize: 12))),
                    if (log.durationMinutes != null)
                      Expanded(child: Text('⏱️ ${log.durationMinutes} min', style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}