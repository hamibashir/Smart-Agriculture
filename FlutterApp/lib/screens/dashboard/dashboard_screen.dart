import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';
import '../fields/add_field_screen.dart';
import '../home/home_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final authProvider = context.read<AuthProvider>();

    try {
      final response = await _apiService.getDashboardStats();
      if (!mounted) return;
      if (response['success'] == true) {
        setState(() {
          _stats = response['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (e.toString().contains('Unauthorized')) {
        await authProvider.logout();
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
              expandedHeight: 120,
              pinned: true,
              backgroundColor: AppTheme.primaryGreen,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppTheme.primaryGreen, AppTheme.darkGreen],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Hi, $firstName!',
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Welcome to Smart Agriculture',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () => context.findAncestorStateOfType<HomeScreenState>()?.navigateToTab(4),
                    ),
                    if ((_stats?['unread_alerts'] ?? 0) > 0)
                      const Positioned(
                        right: 8,
                        top: 8,
                        child: _NotificationDot(),
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
                    Text('Conditions: ${_stats!['latest_field_name'] ?? 'Farm'}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _StatCard('Active Fields', stats['total_fields']?.toString() ?? '0', Icons.landscape, const Color(0xFF22c55e)),
        _StatCard('Live Sensors', stats['active_sensors']?.toString() ?? '0', Icons.sensors, const Color(0xFF3b82f6)),
        _StatCard('Pending AI Tips', stats['ai_tips']?.toString() ?? '0', Icons.psychology, const Color(0xFF8b5cf6)),
        _StatCard('System Issues', stats['unread_alerts']?.toString() ?? '0', Icons.warning_amber_rounded, const Color(0xFFf59e0b)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.title, this.value, this.icon, this.color);

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(title, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            ],
          ),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _ConditionRow('Soil Moisture', '${stats['avg_soil_moisture']?.toStringAsFixed(1) ?? '0'}%', Icons.water_drop, const Color(0xFF3b82f6)),
          const Divider(height: 16),
          _ConditionRow('Temperature', '${stats['avg_temperature']?.toStringAsFixed(1) ?? '0'}°C', Icons.thermostat, const Color(0xFFf59e0b)),
          const Divider(height: 16),
          _ConditionRow('Humidity', '${stats['avg_humidity']?.toStringAsFixed(1) ?? '0'}%', Icons.cloud, const Color(0xFF22c55e)),
          const Divider(height: 16),
          _ConditionRow('Light Level', '${stats['light_intensity']?.toStringAsFixed(1) ?? '0'}%', Icons.wb_sunny, const Color(0xFFeab308)),
          const Divider(height: 16),
          _ConditionRow('Rainfall', (stats['rainfall'] == 1 || (stats['rainfall'] ?? 0) > 0) ? 'Raining' : 'Clear', Icons.grain, const Color(0xFF64748b)),
          const Divider(height: 16),
          _PumpStatusRow(isOn: (stats['pump_on'] == 1 || (stats['pump_on'] ?? 0) > 0)),
        ],
      ),
    );
  }
}

class _ConditionRow extends StatelessWidget {
  const _ConditionRow(this.label, this.value, this.icon, this.color);

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}

class _PumpStatusRow extends StatelessWidget {
  const _PumpStatusRow({required this.isOn});

  final bool isOn;

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF22c55e);
    const inactiveColor = Color(0xFF94a3b8);
    final color = isOn ? activeColor : inactiveColor;

    return Row(
      children: [
        Icon(Icons.water_outlined, color: color, size: 20),
        const SizedBox(width: 12),
        const Expanded(child: Text('Water Pump', style: TextStyle(fontSize: 14))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 5),
              Text(
                isOn ? 'ON' : 'OFF',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color),
              ),
            ],
          ),
        ),
      ],
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
