import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/field_selection_provider.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';
import '../fields/add_field_screen.dart';
import '../home/home_screen.dart';
import '../../models/field.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _stats;
  bool _isLoading = true;
  String? _error;
  List<Field> _fields = [];
  int? _selectedFieldId;
  int? _syncedFieldId;

  String _getGreetingTime() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sharedFieldId = context.watch<FieldSelectionProvider>().selectedFieldId;
    if (_syncedFieldId == sharedFieldId) return;

    _syncedFieldId = sharedFieldId;
    if (!_isLoading && _selectedFieldId != sharedFieldId) {
      _selectedFieldId = sharedFieldId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _loadDashboardData();
        }
      });
    }
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final authProvider = context.read<AuthProvider>();
    final fieldSelectionProvider = context.read<FieldSelectionProvider>();

    try {
      final fieldsRes = await _apiService.getFields();
      if (!mounted) return;
      if (fieldsRes['success'] == true) {
        _fields = (fieldsRes['data'] as List).map((j) => Field.fromJson(j)).toList();
      }

      final persistedFieldId = fieldSelectionProvider.selectedFieldId;
      final hasPersistedField = persistedFieldId != null && _fields.any((field) => field.fieldId == persistedFieldId);
      final activeFieldId = hasPersistedField ? persistedFieldId : (_fields.isNotEmpty ? _fields.first.fieldId : null);

      if (_selectedFieldId != activeFieldId) {
        _selectedFieldId = activeFieldId;
      }

      if (!hasPersistedField && activeFieldId != fieldSelectionProvider.selectedFieldId) {
        await fieldSelectionProvider.setSelectedFieldId(activeFieldId);
      }

      final response = await _apiService.getDashboardStats(fieldId: _selectedFieldId);
      if (!mounted) return;
      if (response['success'] == true) {
        setState(() {
          _stats = response['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (e.toString().contains('Unauthorized')) {
        await authProvider.logoutAndClearFieldSelection(fieldSelectionProvider);
        if (!mounted) return;
        await Navigator.pushReplacementNamed(context, '/login');
        return;
      }
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load data';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstName = context.read<AuthProvider>().user?.fullName.split(' ').first ?? 'Farmer';

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        color: AppTheme.primaryGreen,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              shape: const Border(bottom: BorderSide(color: Color(0xFFf1f5f9), width: 1.5)),
              elevation: 0,
              toolbarHeight: 80,
              title: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Text('👨‍🌾', style: TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Good ${_getGreetingTime()}',
                        style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        firstName,
                        style: const TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 2))
                        ],
                        border: Border.all(color: const Color(0xFFf1f5f9), width: 1.5),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: AppTheme.textPrimary, size: 22),
                        onPressed: () => context.findAncestorStateOfType<HomeScreenState>()?.navigateToTab(4),
                      ),
                    ),
                    if ((_stats?['unread_alerts'] ?? 0) > 0)
                      Positioned(
                        right: 18,
                        top: 20,
                        child: Container(
                          width: 8, height: 8,
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (_isLoading)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (_error != null)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: AppTheme.errorColor),
                      const SizedBox(height: 16),
                      const Text('Failed to load dashboard', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      ElevatedButton(onPressed: _loadDashboardData, child: const Text('Retry')),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _StatsGrid(stats: _stats!),
                    const SizedBox(height: 24),
                    const Text('Field Conditions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    if (_fields.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFe5e7eb)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _selectedFieldId,
                            isExpanded: true,
                            hint: const Text('Select a field...'),
                            icon: const Icon(Icons.expand_more_rounded, color: AppTheme.primaryGreen),
                            items: _fields.map((f) => DropdownMenuItem<int>(
                              value: f.fieldId,
                              child: Row(
                                children: [
                                  const Icon(Icons.grass, size: 18, color: AppTheme.primaryGreen),
                                  const SizedBox(width: 8),
                                  Text(f.fieldName, style: const TextStyle(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )).toList(),
                            onChanged: (fieldId) {
                              if (fieldId != null) {
                                context.read<FieldSelectionProvider>().setSelectedFieldId(fieldId);
                                setState(() => _selectedFieldId = fieldId);
                                _loadDashboardData();
                              }
                            },
                          ),
                        ),
                      )
                    else
                      Text('Conditions: ${_stats!['latest_field_name'] ?? 'Farm'}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 12),
                    _ConditionsCard(stats: _stats!),
                    const SizedBox(height: 24),
                    const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    const _QuickActions(),
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationDot extends StatelessWidget {
  const _NotificationDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats});

  final Map<String, dynamic> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFf1f5f9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem('Fields', stats['total_fields']?.toString() ?? '0', Icons.landscape, const Color(0xFF22c55e)),
          _divider(),
          _StatItem('Sensors', stats['active_sensors']?.toString() ?? '0', Icons.sensors, const Color(0xFF3b82f6)),
          _divider(),
          _StatItem('AI Tips', stats['ai_tips']?.toString() ?? '0', Icons.psychology, const Color(0xFF8b5cf6)),
          _divider(),
          _StatItem('Issues', stats['unread_alerts']?.toString() ?? '0', Icons.warning_amber_rounded, const Color(0xFFf59e0b)),
        ],
      ),
    );
  }

  Widget _divider() => Container(height: 40, width: 1.5, color: const Color(0xFFf1f5f9));
}

class _StatItem extends StatelessWidget {
  const _StatItem(this.title, this.value, this.icon, this.color);

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textSecondary), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _ConditionsCard extends StatelessWidget {
  const _ConditionsCard({required this.stats});

  final Map<String, dynamic> stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _ConditionGridItem('Moisture', '${stats['avg_soil_moisture']?.toStringAsFixed(1) ?? '0'}%', Icons.water_drop_rounded, const Color(0xFF3b82f6))),
            const SizedBox(width: 12),
            Expanded(child: _ConditionGridItem('Temperature', '${stats['avg_temperature']?.toStringAsFixed(1) ?? '0'}°C', Icons.thermostat_rounded, const Color(0xFFf59e0b))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _ConditionGridItem('Humidity', '${stats['avg_humidity']?.toStringAsFixed(1) ?? '0'}%', Icons.cloud_rounded, const Color(0xFF22c55e))),
            const SizedBox(width: 12),
            Expanded(child: _ConditionGridItem('Light', '${stats['light_intensity']?.toStringAsFixed(1) ?? '0'}%', Icons.wb_sunny_rounded, const Color(0xFFeab308))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _ConditionGridItem('Rainfall', (stats['rainfall'] == 1 || (stats['rainfall'] ?? 0) > 0) ? 'Raining' : 'Clear', Icons.grain_rounded, const Color(0xFF64748b))),
            const SizedBox(width: 12),
            Expanded(child: _PumpGridItem(isOn: (stats['pump_on'] == 1 || (stats['pump_on'] ?? 0) > 0))),
          ],
        ),
      ],
    );
  }
}

class _ConditionGridItem extends StatelessWidget {
  const _ConditionGridItem(this.label, this.value, this.icon, this.color);

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFf1f5f9), width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textPrimary), maxLines: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PumpGridItem extends StatelessWidget {
  const _PumpGridItem({required this.isOn});
  final bool isOn;

  @override
  Widget build(BuildContext context) {
    final color = isOn ? AppTheme.successColor : const Color(0xFF94a3b8);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFf1f5f9), width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(Icons.water_rounded, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Pump', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
                const SizedBox(height: 2),
                Text(
                  isOn ? 'ON' : 'OFF',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _ActionButton('Add Field', Icons.add_location_alt, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddFieldScreen())))),
            const SizedBox(width: 12),
            Expanded(child: _ActionButton('Irrigation', Icons.water, () => context.findAncestorStateOfType<HomeScreenState>()?.navigateToTab(2))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _ActionButton('Sensors', Icons.sensors, () => context.findAncestorStateOfType<HomeScreenState>()?.navigateToTab(1))),
            const SizedBox(width: 12),
            Expanded(child: _ActionButton('Tips', Icons.lightbulb, () => context.findAncestorStateOfType<HomeScreenState>()?.navigateToTab(3))),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton(this.label, this.icon, this.onTap);

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppTheme.primaryGreen),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
              const Icon(Icons.arrow_forward_ios, size: 12, color: AppTheme.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
