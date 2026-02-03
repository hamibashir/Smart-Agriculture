import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/api_service.dart';
import '../../models/field.dart';
import '../../models/recommendation.dart';
import '../../config/app_theme.dart';

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

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  Future<void> _loadFields() async {
    try {
      final response = await _apiService.getFields();
      if (response['success'] == true) {
        setState(() {
          _fields = (response['data'] as List).map((json) => Field.fromJson(json)).toList();
          if (_fields.isNotEmpty) {
            _selectedField = _fields.first;
            _loadRecommendations();
          }
          _isLoading = false;
        });
      }
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadRecommendations() async {
    if (_selectedField == null) return;
    try {
      final response = await _apiService.getRecommendations(_selectedField!.fieldId);
      if (response['success'] == true) {
        setState(() => _recommendations = (response['data'] as List).map((json) => CropRecommendation.fromJson(json)).toList());
      }
    } catch (_) {}
  }

  Future<void> _acceptRecommendation(int recommendationId) async {
    try {
      final response = await _apiService.acceptRecommendation(recommendationId);
      if (response['success'] == true) {
        _showSnackBar('Recommendation accepted', AppTheme.successColor);
        _loadRecommendations();
      }
    } catch (_) {
      _showSnackBar('Failed to accept recommendation', AppTheme.errorColor);
    }
  }

  void _showSnackBar(String message, Color color) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Recommendations')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fields.isEmpty
              ? const _EmptyFieldsState()
              : Column(
                  children: [
                    _FieldSelector(
                      fields: _fields,
                      selectedField: _selectedField,
                      onChanged: (field) {
                        setState(() {
                          _selectedField = field;
                          _loadRecommendations();
                        });
                      },
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: _recommendations.isEmpty
                          ? const _NoRecommendations()
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _recommendations.length,
                              itemBuilder: (_, index) => _RecommendationCard(
                                recommendation: _recommendations[index],
                                onAccept: () => _acceptRecommendation(_recommendations[index].recommendationId),
                              ),
                            ),
                    ),
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
          Icon(Icons.eco_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('No fields available', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Add a field to get crop recommendations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

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
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: DropdownButtonFormField<Field>(
        value: selectedField,
        decoration: const InputDecoration(labelText: 'Select Field', prefixIcon: Icon(Icons.grass)),
        items: fields.map((field) => DropdownMenuItem(value: field, child: Text(field.fieldName))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _NoRecommendations extends StatelessWidget {
  const _NoRecommendations();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lightbulb_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('No recommendations yet', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Recommendations will appear based on\nyour field conditions',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({
    required this.recommendation,
    required this.onAccept,
  });

  final CropRecommendation recommendation;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final confidencePercent = ((recommendation.confidenceScore ?? 0.0) * 100).toInt();
    final isHighConfidence = confidencePercent >= 70;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.eco, color: AppTheme.primaryGreen, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recommendation.recommendedCrop, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.verified, size: 16, color: isHighConfidence ? AppTheme.successColor : AppTheme.warningColor),
                          const SizedBox(width: 4),
                          Text(
                            '$confidencePercent% Confidence',
                            style: TextStyle(
                              fontSize: 14,
                              color: isHighConfidence ? AppTheme.successColor : AppTheme.warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (recommendation.isAccepted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('ACCEPTED', style: TextStyle(color: AppTheme.successColor, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
            if (recommendation.recommendationReason != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.infoColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.infoColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 20, color: AppTheme.infoColor),
                    const SizedBox(width: 8),
                    Expanded(child: Text(recommendation.recommendationReason!, style: Theme.of(context).textTheme.bodyMedium)),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                if (recommendation.growthDurationDays != null)
                  _DetailChip(Icons.calendar_today, 'Growth Period', '${recommendation.growthDurationDays} days'),
                if (recommendation.waterRequirement != null)
                  _DetailChip(Icons.water_drop, 'Water Need', recommendation.waterRequirement!),
                if (recommendation.expectedYield != null)
                  _DetailChip(Icons.agriculture, 'Expected Yield', '${recommendation.expectedYield!.toStringAsFixed(1)} tons'),
                if (recommendation.season != null)
                  _DetailChip(Icons.wb_sunny, 'Season', recommendation.season!),
              ],
            ),
            if (!recommendation.isAccepted) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onAccept,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Accept Recommendation'),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text('Generated on ${DateFormat('MMM dd, yyyy').format(recommendation.createdAt)}', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.textSecondary),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
              Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}