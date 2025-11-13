import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/field.dart';
import '../../models/recommendation.dart';
import '../../config/app_theme.dart';
import 'package:intl/intl.dart';

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
        final fieldsData = response['data'] as List;
        setState(() {
          _fields = fieldsData.map((json) => Field.fromJson(json)).toList();
          if (_fields.isNotEmpty) {
            _selectedField = _fields.first;
            _loadRecommendations();
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Load Fields Error: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadRecommendations() async {
    if (_selectedField == null) return;

    try {
      final response = await _apiService.getRecommendations(_selectedField!.fieldId);
      if (response['success'] == true) {
        final recsData = response['data'] as List;
        setState(() {
          _recommendations = recsData.map((json) => CropRecommendation.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('❌ Error loading recommendations: $e');
    }
  }

  Future<void> _acceptRecommendation(int recommendationId) async {
    try {
      final response = await _apiService.acceptRecommendation(recommendationId);
      
      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recommendation accepted'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        _loadRecommendations();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to accept recommendation: $e'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Recommendations'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fields.isEmpty
              ? _buildEmptyState()
              : _buildContent(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.eco_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No fields available',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Add a field to get crop recommendations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        // Field Selector
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: DropdownButtonFormField<Field>(
            value: _selectedField,
            decoration: const InputDecoration(
              labelText: 'Select Field',
              prefixIcon: Icon(Icons.grass),
            ),
            items: _fields.map((field) {
              return DropdownMenuItem(
                value: field,
                child: Text(field.fieldName),
              );
            }).toList(),
            onChanged: (field) {
              setState(() {
                _selectedField = field;
                _loadRecommendations();
              });
            },
          ),
        ),
        const Divider(height: 1),
        
        // Recommendations List
        Expanded(
          child: _recommendations.isEmpty
              ? _buildNoRecommendations()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _recommendations.length,
                  itemBuilder: (context, index) {
                    final rec = _recommendations[index];
                    return _buildRecommendationCard(rec);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildNoRecommendations() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lightbulb_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No recommendations yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Recommendations will appear based on\nyour field conditions',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(CropRecommendation rec) {
    final confidencePercent = (rec.confidenceScore * 100).toInt();
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.eco,
                    color: AppTheme.primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rec.recommendedCrop,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.verified,
                            size: 16,
                            color: confidencePercent >= 70
                                ? AppTheme.successColor
                                : AppTheme.warningColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$confidencePercent% Confidence',
                            style: TextStyle(
                              fontSize: 14,
                              color: confidencePercent >= 70
                                  ? AppTheme.successColor
                                  : AppTheme.warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (rec.isAccepted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'ACCEPTED',
                      style: TextStyle(
                        color: AppTheme.successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            // Reason
            if (rec.recommendationReason != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.infoColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.infoColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 20,
                      color: AppTheme.infoColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        rec.recommendationReason!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            // Details
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                if (rec.growthDurationDays != null)
                  _buildDetailChip(
                    Icons.calendar_today,
                    'Growth Period',
                    '${rec.growthDurationDays} days',
                  ),
                if (rec.waterRequirement != null)
                  _buildDetailChip(
                    Icons.water_drop,
                    'Water Need',
                    rec.waterRequirement!,
                  ),
                if (rec.expectedYield != null)
                  _buildDetailChip(
                    Icons.agriculture,
                    'Expected Yield',
                    '${rec.expectedYield!.toStringAsFixed(1)} tons',
                  ),
                if (rec.season != null)
                  _buildDetailChip(
                    Icons.wb_sunny,
                    'Season',
                    rec.season!,
                  ),
              ],
            ),
            
            // Accept Button
            if (!rec.isAccepted) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _acceptRecommendation(rec.recommendationId),
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Accept Recommendation'),
                ),
              ),
            ],
            
            // Date
            const SizedBox(height: 12),
            Text(
              'Generated on ${DateFormat('MMM dd, yyyy').format(rec.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.textSecondary),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
