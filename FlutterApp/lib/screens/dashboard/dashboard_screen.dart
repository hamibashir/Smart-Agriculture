import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/dashboard_stat_card.dart';
import '../../widgets/dashboard_condition_row.dart';
import '../fields/add_field_screen.dart';
import '../home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> 
    with AutomaticKeepAliveClientMixin {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _stats;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  @override
  bool get wantKeepAlive => true;

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
      } else {
        throw Exception(response['message'] ?? 'Failed to load dashboard data');
      }
    } catch (e) {
      print('❌ Dashboard Error: $e');
      
      // Check if it's an auth error
      if (e.toString().contains('Unauthorized') || e.toString().contains('401')) {
        // Token expired - logout user
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.logout();
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
        return;
      }
      
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        color: AppTheme.primaryGreen,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Enhanced App Bar
            SliverAppBar(
              expandedHeight: 140,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: AppTheme.primaryGreen,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryGreen,
                        AppTheme.darkGreen,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.agriculture_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Smart Agriculture',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Hi, ${user?.fullName.split(' ')[0] ?? 'Farmer'}!',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.greenAccent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'All systems operational',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
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
                ),
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined, size: 24),
                      color: Colors.white,
                      onPressed: () {
                        // Navigate to alerts tab
                        final homeState = context.findAncestorStateOfType<HomeScreenState>();
                        if (homeState != null) {
                          homeState.navigateToTab(4); // Alerts tab index
                        }
                      },
                    ),
                    if ((_stats?['unread_alerts'] ?? 0) > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${_stats?['unread_alerts'] ?? 0}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),
            
            // Content
            _isLoading
                ? const SliverFillRemaining(child: LoadingShimmer())
                : _error != null
                    ? SliverFillRemaining(child: _buildError())
                    : SliverToBoxAdapter(child: _buildDashboard()),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppTheme.errorColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load dashboard',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            _error ?? 'Unknown error',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadDashboardData,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    if (_stats == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Grid - Optimized Cards with RepaintBoundary
            RepaintBoundary(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                DashboardStatCard(
                  title: 'Fields',
                  value: _stats!['total_fields']?.toString() ?? '0',
                  icon: Icons.landscape_outlined,
                  color: const Color(0xFF22c55e),
                ),
                DashboardStatCard(
                  title: 'Sensors',
                  value: _stats!['active_sensors']?.toString() ?? '0',
                  icon: Icons.sensors_outlined,
                  color: const Color(0xFF3b82f6),
                ),
                DashboardStatCard(
                  title: 'Alerts',
                  value: _stats!['total_alerts']?.toString() ?? '0',
                  icon: Icons.notifications_outlined,
                  color: const Color(0xFFf59e0b),
                  subtitle: '${_stats!['unread_alerts'] ?? 0} new',
                ),
                DashboardStatCard(
                  title: 'Water Saved',
                  value: '${_stats!['water_saved_today'] ?? 0}L',
                  icon: Icons.water_drop_outlined,
                  color: const Color(0xFF10b981),
                  subtitle: 'today',
                ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Current Conditions Section
            Text(
              'Current Conditions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            
            RepaintBoundary(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade100, width: 1),
                ),
                child: Column(
                children: [
                  DashboardConditionRow(
                    label: 'Soil Moisture',
                    value: '${_stats!['avg_soil_moisture']?.toStringAsFixed(1) ?? '0'}%',
                    icon: Icons.water_drop_outlined,
                    color: const Color(0xFF3b82f6),
                    percentage: _stats!['avg_soil_moisture']?.toDouble() ?? 0,
                  ),
                  const Divider(height: 1, color: Color(0xFFF5F5F5)),
                  DashboardConditionRow(
                    label: 'Temperature',
                    value: '${_stats!['avg_temperature']?.toStringAsFixed(1) ?? '0'}°C',
                    icon: Icons.thermostat_outlined,
                    color: const Color(0xFFf59e0b),
                    percentage: (_stats!['avg_temperature']?.toDouble() ?? 0) * 2.5,
                  ),
                  const Divider(height: 1, color: Color(0xFFF5F5F5)),
                  DashboardConditionRow(
                    label: 'Humidity',
                    value: '${_stats!['avg_humidity']?.toStringAsFixed(1) ?? '0'}%',
                    icon: Icons.cloud_outlined,
                    color: const Color(0xFF22c55e),
                    percentage: _stats!['avg_humidity']?.toDouble() ?? 0,
                  ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: _buildModernActionButton(
                    'Add Field',
                    Icons.add_location_alt_outlined,
                    const Color(0xFF22c55e),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddFieldScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildModernActionButton(
                    'Start Irrigation',
                    Icons.water_outlined,
                    const Color(0xFF3b82f6),
                    () {
                      // Navigate to irrigation tab
                      final homeState = context.findAncestorStateOfType<HomeScreenState>();
                      if (homeState != null) {
                        homeState.navigateToTab(2); // Irrigation tab index
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildModernActionButton(
                    'View Sensors',
                    Icons.sensors_outlined,
                    const Color(0xFF8b5cf6),
                    () {
                      // Navigate to fields tab (where sensors are accessed)
                      final homeState = context.findAncestorStateOfType<HomeScreenState>();
                      if (homeState != null) {
                        homeState.navigateToTab(1); // Fields tab index
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildModernActionButton(
                    'Recommendations',
                    Icons.lightbulb_outline,
                    const Color(0xFFf59e0b),
                    () {
                      // Navigate to recommendations tab
                      final homeState = context.findAncestorStateOfType<HomeScreenState>();
                      if (homeState != null) {
                        homeState.navigateToTab(3); // Recommendations tab index
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
  }

  // Lightweight Action Button - Simplified
  Widget _buildModernActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
