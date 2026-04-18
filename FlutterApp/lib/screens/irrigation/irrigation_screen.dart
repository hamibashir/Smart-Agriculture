import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../services/api_service.dart';
import '../../models/field.dart';
import '../../models/irrigation.dart';
import '../../config/app_theme.dart';
import '../../providers/field_selection_provider.dart';

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
  bool _isPumpRunning = false;
  bool _isActionInProgress = false;
  int? _syncedFieldId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadFields();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sharedFieldId = context.watch<FieldSelectionProvider>().selectedFieldId;
    if (_syncedFieldId == sharedFieldId) return;

    _syncedFieldId = sharedFieldId;
    if (!_isLoading && _selectedField?.fieldId != sharedFieldId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _loadFields();
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Field? _resolveSelectedField(List<Field> fields, int? fieldId) {
    for (final field in fields) {
      if (field.fieldId == fieldId) {
        return field;
      }
    }

    return fields.isNotEmpty ? fields.first : null;
  }

  Future<void> _loadFields() async {
    try {
      final response = await _apiService.getFields();
      if (!mounted) return;
      if (response['success'] == true) {
        final fields = (response['data'] as List).map((json) => Field.fromJson(json)).toList();
        final sharedFieldId = context.read<FieldSelectionProvider>().selectedFieldId;
        final selectedField = _resolveSelectedField(fields, sharedFieldId);
        setState(() {
          _fields = fields;
          _selectedField = selectedField;
          _isLoading = false;
        });
        await context.read<FieldSelectionProvider>().setSelectedFieldId(selectedField?.fieldId);
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
        final logs = (response['data'] as List).map((json) => IrrigationLog.fromJson(json)).toList();
        setState(() {
          _logs = logs;
          _isPumpRunning = logs.isNotEmpty && logs.first.pumpStatus == 'on';
        });
      }
    } catch (_) {}
  }

  Future<void> _startIrrigation() async {
    if (_selectedField == null || _isActionInProgress) return;
    setState(() => _isActionInProgress = true);

    try {
      final response = await _apiService.startIrrigation({
        'field_id': _selectedField!.fieldId,
        'irrigation_type': 'manual',
        'duration_minutes': 30,
      });
      if (response['success'] == true) {
        if (!mounted) return;
        setState(() => _isPumpRunning = true);
        _showFeedbackToast(
          title: 'Pump started',
          message: '${_selectedField!.fieldName} is now irrigating.',
          color: AppTheme.successColor,
          icon: Icons.play_circle_outline_rounded,
        );
        await _loadLogs();
      }
    } catch (error) {
      final message = error.toString().toLowerCase().contains('already in progress')
          ? 'Pump is already running'
          : 'Unable to start the pump right now';
      _showFeedbackToast(
        title: 'Start request not completed',
        message: message,
        color: AppTheme.warningColor,
        icon: Icons.info_outline_rounded,
      );
    } finally {
      if (mounted) setState(() => _isActionInProgress = false);
    }
  }

  Future<void> _stopIrrigation() async {
    if (_selectedField == null || _isActionInProgress) return;
    setState(() => _isActionInProgress = true);
    try {
      final response = await _apiService.stopIrrigation(_selectedField!.fieldId);
      if (response['success'] == true) {
        if (!mounted) return;
        setState(() => _isPumpRunning = false);
        _showFeedbackToast(
          title: 'Pump stopped',
          message: '${_selectedField!.fieldName} irrigation has been turned off.',
          color: AppTheme.infoColor,
          icon: Icons.stop_circle_outlined,
        );
        await _loadLogs();
      }
    } catch (error) {
      final message = error.toString().toLowerCase().contains('no active irrigation')
          ? 'Pump is already off'
          : 'Unable to stop the pump right now';
      _showFeedbackToast(
        title: 'Stop request not completed',
        message: message,
        color: AppTheme.warningColor,
        icon: Icons.info_outline_rounded,
      );
    } finally {
      if (mounted) setState(() => _isActionInProgress = false);
    }
  }

  void _showFeedbackToast({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: const Duration(milliseconds: 2600),
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 18),
        padding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.14)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.16),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                      isPumpRunning: _isPumpRunning,
                      isActionInProgress: _isActionInProgress,
                      onFieldChanged: (field) {
                        setState(() => _selectedField = field);
                        context.read<FieldSelectionProvider>().setSelectedFieldId(field?.fieldId);
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
    required this.isPumpRunning,
    required this.isActionInProgress,
    required this.onFieldChanged,
    required this.onStart,
    required this.onStop,
  });

  final List<Field> fields;
  final Field? selectedField;
  final bool isPumpRunning;
  final bool isActionInProgress;
  final ValueChanged<Field?> onFieldChanged;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Fields Selector
          const Text('Active Field', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFe2e8f0), width: 1.5),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Field>(
                key: ValueKey(selectedField?.fieldId),
                value: selectedField,
                isExpanded: true,
                icon: const Icon(Icons.expand_more_rounded, color: AppTheme.textPrimary),
                items: fields.map((field) => DropdownMenuItem(
                  value: field, 
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: AppTheme.primaryGreen.withValues(alpha: 0.1), shape: BoxShape.circle),
                        child: const Icon(Icons.grass, size: 16, color: AppTheme.primaryGreen),
                      ),
                      const SizedBox(width: 12),
                      Text(field.fieldName, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                    ],
                  )
                )).toList(),
                onChanged: onFieldChanged,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Central Graphic
          _PumpStatusDisplay(isPumpRunning: isPumpRunning),
          const SizedBox(height: 42),

          // Start & Stop Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: isActionInProgress ? null : onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: isActionInProgress && !isPumpRunning
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow_rounded),
                            SizedBox(width: 8),
                            Text('Start', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: isActionInProgress ? null : onStop,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    foregroundColor: AppTheme.errorColor,
                    side: const BorderSide(color: AppTheme.errorColor, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: isActionInProgress && isPumpRunning
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.errorColor))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stop_rounded),
                            SizedBox(width: 8),
                            Text('Stop', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PumpStatusDisplay extends StatefulWidget {
  const _PumpStatusDisplay({required this.isPumpRunning});

  final bool isPumpRunning;

  @override
  State<_PumpStatusDisplay> createState() => _PumpStatusDisplayState();
}

class _PumpStatusDisplayState extends State<_PumpStatusDisplay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    if (widget.isPumpRunning) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant _PumpStatusDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPumpRunning == oldWidget.isPumpRunning) return;

    if (widget.isPumpRunning) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.animateTo(0, duration: const Duration(milliseconds: 300));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isPumpRunning ? AppTheme.primaryGreen : AppTheme.infoColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pulse = widget.isPumpRunning ? _controller.value : 0.0;
        final ringScale = 1 + (pulse * 0.12);
        final ringOpacity = widget.isPumpRunning ? (0.20 - (pulse * 0.12)) : 0.08;

        return Column(
          children: [
            SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: ringScale,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: baseColor.withValues(alpha: ringOpacity),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: baseColor.withValues(alpha: widget.isPumpRunning ? 0.18 : 0.08),
                          blurRadius: widget.isPumpRunning ? 34 : 22,
                          spreadRadius: widget.isPumpRunning ? 8 : 2,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          scale: widget.isPumpRunning ? 1.06 : 1,
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOut,
                          child: Icon(Icons.water_drop, size: 64, color: baseColor),
                        ),
                        const SizedBox(height: 16),
                        const Text('Water Pump', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                        const SizedBox(height: 4),
                        Text(
                          widget.isPumpRunning ? 'Currently Running' : 'Manual Override',
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.isPumpRunning ? AppTheme.primaryGreen : AppTheme.textSecondary,
                            fontWeight: widget.isPumpRunning ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: (widget.isPumpRunning ? AppTheme.successColor : AppTheme.warningColor).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                widget.isPumpRunning ? 'Pump ON' : 'Pump OFF',
                style: TextStyle(
                  color: widget.isPumpRunning ? AppTheme.successColor : AppTheme.warningColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      },
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
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFf1f5f9), width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: log.irrigationType == 'automatic' ? AppTheme.infoColor.withValues(alpha: 0.1) : const Color(0xFF8b5cf6).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(log.irrigationType == 'automatic' ? Icons.auto_mode_rounded : Icons.touch_app_rounded, color: log.irrigationType == 'automatic' ? AppTheme.infoColor : const Color(0xFF8b5cf6), size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(log.irrigationType.toUpperCase(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
                    const SizedBox(height: 2),
                    Text(DateFormat('MMM dd, yyyy • hh:mm a').format(log.startTime), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: log.pumpStatus == 'on' ? AppTheme.successColor.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: log.pumpStatus == 'on' ? AppTheme.successColor : Colors.grey, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text(
                      log.pumpStatus.toUpperCase(),
                      style: TextStyle(
                        color: log.pumpStatus == 'on' ? AppTheme.successColor : Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (log.waterUsedLiters != null || log.durationMinutes != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                if (log.waterUsedLiters != null) 
                   Expanded(child: Text('💧 Volume: ${log.waterUsedLiters!.toStringAsFixed(1)}L', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                if (log.durationMinutes != null) 
                   Expanded(child: Text('⏱️ Duration: ${log.durationMinutes} min', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), textAlign: TextAlign.right)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

