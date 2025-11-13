import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/alert.dart';
import '../../config/app_theme.dart';
import 'package:intl/intl.dart';

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
        final alertsData = response['data'] as List;
        setState(() {
          _alerts = alertsData.map((json) => Alert.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception(response['message'] ?? 'Failed to load alerts');
      }
    } catch (e) {
      print('❌ Alerts Error: $e');
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _markAsRead(int alertId) async {
    try {
      await _apiService.markAsRead(alertId);
      _loadAlerts();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _resolveAlert(int alertId) async {
    try {
      await _apiService.resolveAlert(alertId);
      _loadAlerts();
    } catch (e) {
      // Handle error
    }
  }

  Color _getAlertColor(String type) {
    switch (type) {
      case 'critical':
        return AppTheme.errorColor;
      case 'warning':
        return AppTheme.warningColor;
      case 'success':
        return AppTheme.successColor;
      default:
        return AppTheme.infoColor;
    }
  }

  IconData _getAlertIcon(String category) {
    switch (category) {
      case 'soil_moisture':
        return Icons.water_drop;
      case 'temperature':
        return Icons.thermostat;
      case 'humidity':
        return Icons.cloud;
      case 'irrigation':
        return Icons.water;
      case 'sensor_offline':
        return Icons.sensors_off;
      case 'crop_health':
        return Icons.eco;
      case 'weather':
        return Icons.wb_sunny;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAlerts,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildError()
              : _alerts.isEmpty
                  ? _buildEmptyState()
                  : _buildAlertsList(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
          const SizedBox(height: 16),
          Text('Failed to load alerts', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadAlerts,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No alerts',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return RefreshIndicator(
      onRefresh: _loadAlerts,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _alerts.length,
        itemBuilder: (context, index) {
          final alert = _alerts[index];
          return _buildAlertCard(alert);
        },
      ),
    );
  }

  Widget _buildAlertCard(Alert alert) {
    final color = _getAlertColor(alert.alertType);
    final icon = _getAlertIcon(alert.alertCategory);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (!alert.isRead) {
            _markAsRead(alert.alertId);
          }
        },
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
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
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
              Text(
                alert.message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (!alert.isResolved) ...[
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => _resolveAlert(alert.alertId),
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
