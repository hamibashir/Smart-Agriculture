import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import '../../models/field.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  List<Field> _fields = [];
  
  Field? _field1;
  Field? _field2;
  
  List<dynamic> _readings = [];
  Map<String, dynamic>? _stats1;
  Map<String, dynamic>? _stats2;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final res = await _apiService.getFields();
      if (res['success'] == true) {
        _fields = (res['data'] as List).map((f) => Field.fromJson(f)).toList();
        if (_fields.isNotEmpty) {
          _field1 = _fields.first;
          if (_fields.length > 1) _field2 = _fields[1];
          await _loadDataForFields();
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadDataForFields() async {
    if (_field1 != null) {
      try {
        final sRes = await _apiService.getFieldSensors(_field1!.fieldId);
        if (sRes['success'] == true && (sRes['data'] as List).isNotEmpty) {
          final sensorId = sRes['data'][0]['sensor_id'];
          final rRes = await _apiService.getSensorReadings(sensorId);
          if (rRes['success'] == true) {
            _readings = rRes['data'];
          }
        }
        final statRes = await _apiService.getDashboardStats(fieldId: _field1!.fieldId);
        if (statRes['success'] == true) _stats1 = statRes['data'];
      } catch (_) {}
    }
    
    if (_field2 != null) {
      try {
        final statRes = await _apiService.getDashboardStats(fieldId: _field2!.fieldId);
        if (statRes['success'] == true) _stats2 = statRes['data'];
      } catch (_) {}
    }
    
    if (mounted) setState(() {});
  }

  void _exportData() {
    if (_readings.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No data to export')));
      return;
    }
    
    StringBuffer csv = StringBuffer();
    csv.writeln("Time,Soil Moisture,Temperature,Humidity");
    for (var r in _readings) {
      csv.writeln("${r['reading_time']},${r['soil_moisture']},${r['temperature']},${r['humidity']}");
    }
    
    Clipboard.setData(ClipboardData(text: csv.toString()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('✅ Report generated and CSV Data copied to clipboard!'),
      backgroundColor: AppTheme.successColor,
    ));
  }

  Widget _buildTrendChart() {
    if (_readings.isEmpty) {
      return const SizedBox(height: 200, child: Center(child: Text('No historical data available')));
    }

    final data = _readings.take(20).toList().reversed.toList();
    final List<FlSpot> spots = [];
    for (int i = 0; i < data.length; i++) {
      final moisture = double.tryParse(data[i]['soil_moisture'].toString()) ?? 0.0;
      spots.add(FlSpot(i.toDouble(), moisture));
    }

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFf1f5f9)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Weekly Moisture Trends', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ElevatedButton.icon(
                onPressed: _exportData,
                icon: const Icon(Icons.download, size: 16),
                label: const Text('Export'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: spots.length > 1 ? (spots.length - 1).toDouble() : 6.0, // Default to 7 days width if not enough data
                minY: 0,
                maxY: 100, // Moisture is 0-100%
                gridData: const FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Day ${value.toInt() + 1}',
                            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10),
                          ),
                        );
                      },
                      interval: spots.length > 7 ? (spots.length / 7).ceilToDouble() : 1,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots.isEmpty ? [const FlSpot(0, 0)] : spots,
                    isCurved: true,
                    color: AppTheme.primaryGreen,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true), // Show dots so single points are visible!
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparison() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFf1f5f9)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Compare Fields', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Field>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Field 1', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  value: _field1,
                  items: _fields.map((f) => DropdownMenuItem(value: f, child: Text(f.fieldName))).toList(),
                  onChanged: (f) {
                    setState(() => _field1 = f);
                    _loadDataForFields();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<Field>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Field 2', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  value: _field2,
                  items: _fields.map((f) => DropdownMenuItem(value: f, child: Text(f.fieldName))).toList(),
                  onChanged: (f) {
                    setState(() => _field2 = f);
                    _loadDataForFields();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_stats1 != null && _stats2 != null) ...[
            _ComparisonRow('Avg Moisture', '${_stats1!['avg_soil_moisture']?.toStringAsFixed(1) ?? 0}%', '${_stats2!['avg_soil_moisture']?.toStringAsFixed(1) ?? 0}%'),
            const Divider(),
            _ComparisonRow('Avg Temperature', '${_stats1!['avg_temperature']?.toStringAsFixed(1) ?? 0}°C', '${_stats2!['avg_temperature']?.toStringAsFixed(1) ?? 0}°C'),
            const Divider(),
            _ComparisonRow('Current Pump Status', _stats1!['pump_on'] == 1 ? 'ON' : 'OFF', _stats2!['pump_on'] == 1 ? 'ON' : 'OFF'),
            const Divider(),
            _ComparisonRow('Total Alerts', '${_stats1!['unread_alerts'] ?? 0}', '${_stats2!['unread_alerts'] ?? 0}'),
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Historical Analytics'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fields.isEmpty
              ? const Center(child: Text('No fields available to analyze.'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildTrendChart(),
                      const SizedBox(height: 24),
                      _buildComparison(),
                    ],
                  ),
                ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String label, val1, val2;
  const _ComparisonRow(this.label, this.val1, this.val2);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(val1, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.primaryGreen), textAlign: TextAlign.center)),
          Expanded(child: Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
          Expanded(child: Text(val2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue), textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
