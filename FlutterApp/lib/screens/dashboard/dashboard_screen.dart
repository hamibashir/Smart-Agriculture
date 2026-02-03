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

    try {
      final response = await _apiService.getDashboardStats();
      if (response['success'] == true) {
        setState(() {
          _stats = response['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (e.toString().contains('Unauthorized')) {
        await context.read<AuthProvider>().logout();
        if (mounted) Navigator.pushReplacementNamed(context, '/login');
        return;
      }
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
                    const Text('Current Conditions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        _StatCard('Fields', stats['total_fields']?.toString() ?? '0', Icons.landscape, const Color(0xFF22c55e)),
        _StatCard('Sensors', stats['active_sensors']?.toString() ?? '0', Icons.sensors, const Color(0xFF3b82f6)),
        _StatCard('Alerts', stats['total_alerts']?.toString() ?? '0', Icons.notifications, const Color(0xFFf59e0b)),
        _StatCard('Water', '${stats['water_saved_today'] ?? 0}L', Icons.water_drop, const Color(0xFF10b981)),
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
          const Divider(height: 24),
          _ConditionRow('Temperature', '${stats['avg_temperature']?.toStringAsFixed(1) ?? '0'}°C', Icons.thermostat, const Color(0xFFf59e0b)),
          const Divider(height: 24),
          _ConditionRow('Humidity', '${stats['avg_humidity']?.toStringAsFixed(1) ?? '0'}%', Icons.cloud, const Color(0xFF22c55e)),
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