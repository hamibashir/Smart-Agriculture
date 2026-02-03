import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/api_service.dart';
import '../../models/alert.dart';
import '../../config/app_theme.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final ApiService _apiService = ApiService();
  List<Alert> _alerts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  Future<void> _loadAlerts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _apiService.getAlerts();
      if (response['success'] == true) {
        setState(() {
          _alerts = (response['data'] as List).map((json) => Alert.fromJson(json)).toList();
          _isLoading = false;
        });
      }
    } catch (_) {
      setState(() {
        _error = 'Failed to load alerts';
        _isLoading = false;
      });
    }
  }

  Future<void> _markAsRead(int alertId) async {
    try {
      await _apiService.markAsRead(alertId);
      _loadAlerts();
    } catch (_) {}
  }

  Future<void> _resolveAlert(int alertId) async {
    try {
      await _apiService.resolveAlert(alertId);
      _loadAlerts();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _loadAlerts)],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(onRetry: _loadAlerts)
              : _alerts.isEmpty
                  ? const _EmptyState()
                  : RefreshIndicator(
                      onRefresh: _loadAlerts,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _alerts.length,
                        itemBuilder: (_, index) => _AlertCard(
                          alert: _alerts[index],
                          onMarkRead: () => _markAsRead(_alerts[index].alertId),
                          onResolve: () => _resolveAlert(_alerts[index].alertId),
                        ),
                      ),
                    ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
          const SizedBox(height: 16),
          Text('Failed to load alerts', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('No alerts', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            "You're all caught up!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({
    required this.alert,
    required this.onMarkRead,
    required this.onResolve,
  });

  final Alert alert;
  final VoidCallback onMarkRead;
  final VoidCallback onResolve;

  static Color _getColor(String type) => switch (type) {
        'critical' => AppTheme.errorColor,
        'warning' => AppTheme.warningColor,
        'success' => AppTheme.successColor,
        _ => AppTheme.infoColor,
      };

  static IconData _getIcon(String category) => switch (category) {
        'soil_moisture' => Icons.water_drop,
        'temperature' => Icons.thermostat,
        'humidity' => Icons.cloud,
        'irrigation' => Icons.water,
        'sensor_offline' => Icons.sensors_off,
        'crop_health' => Icons.eco,
        'weather' => Icons.wb_sunny,
        _ => Icons.notifications,
      };

  @override
  Widget build(BuildContext context) {
    final color = _getColor(alert.alertType);
    final icon = _getIcon(alert.alertCategory);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: alert.isRead ? null : onMarkRead,
        borderRadius: BorderRadius.circular(12),
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
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                alert.title,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: alert.isRead ? FontWeight.normal : FontWeight.bold,
                                    ),
                              ),
                            ),
                            if (!alert.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('MMM dd, yyyy • hh:mm a').format(alert.createdAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(alert.message, style: Theme.of(context).textTheme.bodyMedium),
              if (!alert.isResolved) ...[
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: onResolve,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: color,
                    side: BorderSide(color: color),
                  ),
                  child: const Text('Mark as Resolved'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}