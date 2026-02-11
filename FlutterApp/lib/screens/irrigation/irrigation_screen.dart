import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/api_service.dart';
import '../../models/field.dart';
import '../../models/irrigation.dart';
import '../../config/app_theme.dart';

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
      if (!mounted) return;
      if (response['success'] == true) {
        final fields = (response['data'] as List).map((json) => Field.fromJson(json)).toList();
        final selectedField = fields.isNotEmpty ? fields.first : null;
        setState(() {
          _fields = fields;
          _selectedField = selectedField;
          _isLoading = false;
        });
        if (selectedField != null) {
          await _loadLogs();
        }
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadLogs() async {
    if (_selectedField == null) return;
    try {
      final response = await _apiService.getIrrigationLogs(_selectedField!.fieldId);
      if (!mounted) return;
      if (response['success'] == true) {
        setState(() => _logs = (response['data'] as List).map((json) => IrrigationLog.fromJson(json)).toList());
      }
    } catch (_) {}
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
        if (!mounted) return;
        _showSnackBar('Irrigation started', AppTheme.successColor);
        await _loadLogs();
      }
    } catch (_) {
      _showSnackBar('Failed to start irrigation', AppTheme.errorColor);
    } finally {
      if (mounted) setState(() => _isIrrigating = false);
    }
  }

  Future<void> _stopIrrigation() async {
    if (_selectedField == null) return;
    try {
      final response = await _apiService.stopIrrigation(_selectedField!.fieldId);
      if (response['success'] == true) {
        if (!mounted) return;
        _showSnackBar('Irrigation stopped', AppTheme.successColor);
        await _loadLogs();
      }
    } catch (_) {
      _showSnackBar('Failed to stop irrigation', AppTheme.errorColor);
    }
  }

  void _showSnackBar(String message, Color color) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
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
              ? const _EmptyFieldsState()
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _ControlTab(
                      fields: _fields,
                      selectedField: _selectedField,
                      isIrrigating: _isIrrigating,
                      onFieldChanged: (field) {
                        setState(() => _selectedField = field);
                        _loadLogs();
                      },
                      onStart: _startIrrigation,
                      onStop: _stopIrrigation,
                    ),
                    _HistoryTab(logs: _logs),
                  ],
                ),
    );
  }
}

class _EmptyFieldsState extends StatelessWidget {
  const _EmptyFieldsState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.water_drop_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('No fields available', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class _ControlTab extends StatelessWidget {
  const _ControlTab({
    required this.fields,
    required this.selectedField,
    required this.isIrrigating,
    required this.onFieldChanged,
    required this.onStart,
    required this.onStop,
  });

  final List<Field> fields;
  final Field? selectedField;
  final bool isIrrigating;
  final ValueChanged<Field?> onFieldChanged;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
                  key: ValueKey(selectedField?.fieldId),
                  initialValue: selectedField,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.grass)),
                  items: fields.map((field) => DropdownMenuItem(value: field, child: Text(field.fieldName))).toList(),
                  onChanged: onFieldChanged,
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
                        onPressed: isIrrigating ? null : onStart,
                        icon: isIrrigating ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.play_arrow),
                        label: const Text('Start'),
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onStop,
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
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({required this.logs});

  final List<IrrigationLog> logs;

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
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
      itemCount: logs.length,
      itemBuilder: (_, index) => _LogCard(log: logs[index]),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.log});

  final IrrigationLog log;

  @override
  Widget build(BuildContext context) {
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
                  color: log.pumpStatus == 'on' ? AppTheme.successColor.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
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
                if (log.waterUsedLiters != null) Expanded(child: Text('💧 ${log.waterUsedLiters!.toStringAsFixed(1)}L', style: const TextStyle(fontSize: 12))),
                if (log.durationMinutes != null) Expanded(child: Text('⏱️ ${log.durationMinutes} min', style: const TextStyle(fontSize: 12))),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
