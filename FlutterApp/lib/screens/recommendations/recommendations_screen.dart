import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/api_service.dart';
import '../../models/field.dart';
import '../../models/recommendation.dart';
import '../../config/app_theme.dart';

// ── Crop emoji + color lookup ────────────────────────────────
const _cropMeta = {
  'wheat':     {'emoji': '🌾', 'color': Color(0xFFf59e0b)},
  'rice':      {'emoji': '🍚', 'color': Color(0xFF06b6d4)},
  'cotton':    {'emoji': '🤍', 'color': Color(0xFF8b5cf6)},
  'maize':     {'emoji': '🌽', 'color': Color(0xFFf97316)},
  'sugarcane': {'emoji': '🎋', 'color': Color(0xFF10b981)},
  'mustard':   {'emoji': '🌻', 'color': Color(0xFFfbbf24)},
  'chickpea':  {'emoji': '🫘', 'color': Color(0xFFa16207)},
  'sunflower': {'emoji': '🌻', 'color': Color(0xFFfbbf24)},
};

Color _cropColor(String crop) =>
    (_cropMeta[crop.toLowerCase()]?['color'] as Color?) ?? AppTheme.primaryGreen;

String _cropEmoji(String crop) =>
    (_cropMeta[crop.toLowerCase()]?['emoji'] as String?) ?? '🌿';

// ─────────────────────────────────────────────────────────────
class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  final ApiService _apiService = ApiService();

  List<Field> _fields = [];
  List<CropRecommendation> _recommendations = [];
  Field? _selectedField;
  bool _isLoading = true;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  Future<void> _loadFields() async {
    try {
      final response = await _apiService.getFields();
      if (!mounted) return;
      if (response['success'] == true) {
        final fields =
            (response['data'] as List).map((j) => Field.fromJson(j)).toList();
        setState(() {
          _fields = fields;
          _selectedField = fields.isNotEmpty ? fields.first : null;
          _isLoading = false;
        });
        if (_selectedField != null) await _loadRecommendations();
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadRecommendations() async {
    if (_selectedField == null) return;
    setState(() => _isRefreshing = true);
    try {
      final response =
          await _apiService.getRecommendations(_selectedField!.fieldId);
      if (!mounted) return;
      if (response['success'] == true) {
        setState(() {
          _recommendations = (response['data'] as List)
              .map((j) => CropRecommendation.fromJson(j))
              .toList();
        });
      }
    } catch (_) {}
    if (mounted) setState(() => _isRefreshing = false);
  }

  Future<void> _acceptRecommendation(int id) async {
    try {
      final res = await _apiService.acceptRecommendation(id);
      if (!mounted) return;
      if (res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('✅ Recommendation accepted!'),
          backgroundColor: AppTheme.successColor,
        ));
        await _loadRecommendations();
      }
    } catch (_) {}
  }

  Future<void> _deleteRecommendation(int id) async {
    try {
      final res = await _apiService.deleteRecommendation(id);
      if (!mounted) return;
      if (res['success'] == true) {
        setState(() {
          _recommendations.removeWhere((r) => r.recommendationId == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('🗑️ Recommendation deleted.'),
          backgroundColor: AppTheme.textSecondary,
          duration: Duration(seconds: 2),
        ));
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('AI Crop Recommendations'),
        actions: [
          if (_isRefreshing)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: _loadRecommendations,
              tooltip: 'Refresh',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fields.isEmpty
              ? const _EmptyState()
              : RefreshIndicator(
                  onRefresh: _loadRecommendations,
                  color: AppTheme.primaryGreen,
                  child: CustomScrollView(
                    slivers: [
                      // ── AI Banner ──────────────────────────
                      SliverToBoxAdapter(child: _AIBanner()),

                      // ── Field Selector ─────────────────────
                      SliverToBoxAdapter(
                        child: _FieldSelector(
                          fields: _fields,
                          selectedField: _selectedField,
                          onChanged: (f) {
                            setState(() => _selectedField = f);
                            _loadRecommendations();
                          },
                        ),
                      ),

                      // ── Content ────────────────────────────
                      if (_recommendations.isEmpty)
                        const SliverFillRemaining(child: _NoRecommendations())
                      else ...[
                        // Latest / top recommendation hero
                        SliverToBoxAdapter(
                          child: _HeroCard(
                            recommendation: _recommendations.first,
                            onAccept: () => _acceptRecommendation(
                                _recommendations.first.recommendationId),
                            onDelete: () => _deleteRecommendation(
                                _recommendations.first.recommendationId),
                          ),
                        ),

                        // History header
                        if (_recommendations.length > 1)
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                              child: Text(
                                'Previous Recommendations',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ),

                        // History list — swipe left to delete
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, i) {
                              final rec = _recommendations[i + 1];
                              return Dismissible(
                                key: ValueKey(rec.recommendationId),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 24),
                                  margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                                  decoration: BoxDecoration(
                                    color: AppTheme.errorColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26),
                                      SizedBox(height: 4),
                                      Text('Delete', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                confirmDismiss: (_) async {
                                  return await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Delete Recommendation?'),
                                      content: const Text('This recommendation will be permanently removed.'),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, true),
                                          style: TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  ) ?? false;
                                },
                                onDismissed: (_) => _deleteRecommendation(rec.recommendationId),
                                child: _HistoryCard(
                                  recommendation: rec,
                                  onAccept: () => _acceptRecommendation(rec.recommendationId),
                                ),
                              );
                            },
                            childCount: (_recommendations.length - 1).clamp(0, 999),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 24)),
                      ],
                    ],
                  ),
                ),
    );
  }
}

// ── AI Banner ─────────────────────────────────────────────────
class _AIBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF16a34a), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Text('🤖', style: TextStyle(fontSize: 28)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Powered by Random Forest AI',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Recommendations auto-generated from your live sensor data',
                  style: TextStyle(color: Color(0xFFbbf7d0), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Field Selector ────────────────────────────────────────────
class _FieldSelector extends StatelessWidget {
  const _FieldSelector({
    required this.fields,
    required this.selectedField,
    required this.onChanged,
  });

  final List<Field> fields;
  final Field? selectedField;
  final ValueChanged<Field?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFe5e7eb)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Field>(
          value: selectedField,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: fields
              .map((f) => DropdownMenuItem(
                    value: f,
                    child: Row(
                      children: [
                        const Icon(Icons.grass, size: 18, color: AppTheme.primaryGreen),
                        const SizedBox(width: 8),
                        Text(f.fieldName,
                            style: const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ── Hero Card (latest recommendation) ────────────────────────
class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.recommendation, required this.onAccept, required this.onDelete});

  final CropRecommendation recommendation;
  final VoidCallback onAccept;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final crop       = recommendation.recommendedCrop;
    final confidence = recommendation.confidenceScore ?? 0;
    final color      = _cropColor(crop);
    final emoji      = _cropEmoji(crop);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header gradient
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.12), color.withValues(alpha: 0.04)],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                // Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, size: 14, color: color),
                      const SizedBox(width: 4),
                      Text(
                        'AI RECOMMENDATION',
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(emoji, style: const TextStyle(fontSize: 56)),
                const SizedBox(height: 8),
                Text(
                  crop.toUpperCase(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: color,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                if (recommendation.season != null)
                  Text(
                    '${_seasonLabel(recommendation.season!)} Season Crop',
                    style: const TextStyle(
                        color: AppTheme.textSecondary, fontSize: 13),
                  ),
                ],
              ),
              // Delete icon — top right
              Positioned(
                top: -4,
                right: -4,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                  color: Colors.black26,
                  tooltip: 'Delete recommendation',
                  onPressed: onDelete,
                ),
              ),
            ],
          ),
        ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Confidence meter
                _ConfidenceMeter(confidence: confidence, color: color),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),

                // Sensor data that drove prediction
                if (_hasSensorData(recommendation))
                  _SensorDataRow(recommendation: recommendation),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Stat chips
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (recommendation.growthDurationDays != null)
                      _StatChip(
                        icon: Icons.schedule_rounded,
                        label: 'Growth Period',
                        value: '${recommendation.growthDurationDays} days',
                        color: color,
                      ),
                    if (recommendation.waterRequirement != null)
                      _StatChip(
                        icon: Icons.water_drop_rounded,
                        label: 'Water Need',
                        value: recommendation.waterRequirement!,
                        color: color,
                      ),
                    if (recommendation.expectedYield != null)
                      _StatChip(
                        icon: Icons.agriculture_rounded,
                        label: 'Est. Yield',
                        value: '${recommendation.expectedYield!.toStringAsFixed(0)} kg/acre',
                        color: color,
                      ),
                    if (recommendation.soilType != null)
                      _StatChip(
                        icon: Icons.layers_rounded,
                        label: 'Soil Type',
                        value: _capitalize(recommendation.soilType!),
                        color: color,
                      ),
                  ],
                ),

                // AI Reason box
                if (recommendation.recommendationReason != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFeff6ff),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFbfdbfe)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.psychology_rounded,
                            size: 20, color: Color(0xFF3b82f6)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            recommendation.recommendationReason!,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF1e40af)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Model version + date
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (recommendation.modelVersion != null)
                      _Pill('Model v${recommendation.modelVersion}',
                          Icons.smart_toy_rounded),
                    _Pill(
                      DateFormat('MMM dd, yyyy').format(recommendation.createdAt),
                      Icons.calendar_today_rounded,
                    ),
                  ],
                ),

                // Accept button
                if (!recommendation.isAccepted) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: onAccept,
                      icon: const Icon(Icons.check_circle_rounded, size: 20),
                      label: const Text('Accept This Recommendation',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ] else
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: AppTheme.successColor, size: 18),
                        SizedBox(width: 8),
                        Text('Accepted',
                            style: TextStyle(
                                color: AppTheme.successColor,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _hasSensorData(CropRecommendation r) =>
      r.soilMoistureAvg != null || r.temperatureAvg != null || r.humidityAvg != null;
}

// ── Confidence Meter ──────────────────────────────────────────
class _ConfidenceMeter extends StatelessWidget {
  const _ConfidenceMeter({required this.confidence, required this.color});

  final double confidence;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // Backend stores 0-100 already
    final pct = confidence.clamp(0, 100).toDouble();
    final label = pct >= 85
        ? 'Very High'
        : pct >= 70
            ? 'High'
            : pct >= 50
                ? 'Moderate'
                : 'Low';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('AI Confidence',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                    fontSize: 13)),
            Text(
              '${pct.toStringAsFixed(1)}% — $label',
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: color, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: pct / 100,
            minHeight: 10,
            backgroundColor: color.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

// ── Sensor Data Row ───────────────────────────────────────────
class _SensorDataRow extends StatelessWidget {
  const _SensorDataRow({required this.recommendation});

  final CropRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sensor Data Used',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            if (recommendation.soilMoistureAvg != null)
              Expanded(
                child: _SensorTile(
                  icon: Icons.water_outlined,
                  label: 'Moisture',
                  value: '${recommendation.soilMoistureAvg!.toStringAsFixed(1)}%',
                  color: const Color(0xFF06b6d4),
                ),
              ),
            if (recommendation.temperatureAvg != null) ...[
              const SizedBox(width: 8),
              Expanded(
                child: _SensorTile(
                  icon: Icons.thermostat_rounded,
                  label: 'Temp',
                  value: '${recommendation.temperatureAvg!.toStringAsFixed(1)}°C',
                  color: const Color(0xFFf97316),
                ),
              ),
            ],
            if (recommendation.humidityAvg != null) ...[
              const SizedBox(width: 8),
              Expanded(
                child: _SensorTile(
                  icon: Icons.water_drop_outlined,
                  label: 'Humidity',
                  value: '${recommendation.humidityAvg!.toStringAsFixed(1)}%',
                  color: const Color(0xFF8b5cf6),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _SensorTile extends StatelessWidget {
  const _SensorTile(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w700, fontSize: 13)),
          Text(label,
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 10)),
        ],
      ),
    );
  }
}

// ── History Card ──────────────────────────────────────────────
class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.recommendation, required this.onAccept});

  final CropRecommendation recommendation;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final crop       = recommendation.recommendedCrop;
    final confidence = (recommendation.confidenceScore ?? 0).clamp(0, 100).toDouble();
    final color      = _cropColor(crop);
    final emoji      = _cropEmoji(crop);

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
        ),
        title: Text(
          _capitalize(crop),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: confidence / 100,
                minHeight: 5,
                backgroundColor: color.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${confidence.toStringAsFixed(1)}% confidence · ${DateFormat('MMM dd').format(recommendation.createdAt)}',
              style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            ),
          ],
        ),
        trailing: recommendation.isAccepted
            ? const Icon(Icons.check_circle, color: AppTheme.successColor, size: 22)
            : TextButton(
                onPressed: onAccept,
                style: TextButton.styleFrom(
                  foregroundColor: color,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                ),
                child: const Text('Accept',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
              ),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  const _StatChip(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
              Text(value,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text, this.icon);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppTheme.textSecondary),
        const SizedBox(width: 4),
        Text(text,
            style:
                const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
      ],
    );
  }
}

class _NoRecommendations extends StatelessWidget {
  const _NoRecommendations();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Text('🤖', style: TextStyle(fontSize: 48)),
            ),
            const SizedBox(height: 20),
            const Text('No AI Recommendations Yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            const Text(
              'The AI model will automatically generate crop recommendations after your sensor sends enough readings.\n\nMake sure your ESP32 is active and sending data.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFfff7ed),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFfed7aa)),
              ),
              child: const Row(
                children: [
                  Text('💡', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Recommendations are generated every 10 sensor readings automatically.',
                      style: TextStyle(color: Color(0xFF92400e), fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🌾', style: TextStyle(fontSize: 64)),
          SizedBox(height: 16),
          Text('No Fields Added',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text('Add a field first to get AI crop recommendations',
              style: TextStyle(color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}

// ── Utilities ─────────────────────────────────────────────────
String _capitalize(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

String _seasonLabel(String season) =>
    season.toLowerCase() == 'rabi' ? '❄️ Rabi' : '☀️ Kharif';
