import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/field.dart';
import '../../config/app_theme.dart';
import 'field_detail_screen.dart';
import 'add_field_screen.dart';

class FieldsScreen extends StatefulWidget {
  const FieldsScreen({super.key});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  final ApiService _apiService = ApiService();
  List<Field> _fields = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  Future<void> _loadFields() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _apiService.getFields();
      if (response['success'] == true) {
        setState(() {
          _fields = (response['data'] as List).map((json) => Field.fromJson(json)).toList();
          _isLoading = false;
        });
      }
    } catch (_) {
      setState(() {
        _error = 'Failed to load fields';
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToAddField() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddFieldScreen()));
    if (result == true) _loadFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Fields'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _loadFields)],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(onRetry: _loadFields)
              : _fields.isEmpty
                  ? _EmptyState(onAdd: _navigateToAddField)
                  : RefreshIndicator(
                      onRefresh: _loadFields,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _fields.length,
                        itemBuilder: (_, index) => _FieldCard(field: _fields[index]),
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddField,
        child: const Icon(Icons.add),
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
          const Icon(Icons.error_outline, size: 48, color: AppTheme.errorColor),
          const SizedBox(height: 16),
          const Text('Failed to load fields', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.grass_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('No fields yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Add your first field to get started', style: TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Add Field'),
          ),
        ],
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  const _FieldCard({required this.field});

  final Field field;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FieldDetailScreen(field: field))),
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
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.grass, color: AppTheme.primaryGreen, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(field.fieldName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        Text('${field.areaSize} ${field.areaUnit}', style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                      ],
                    ),
                  ),
                  _StatusBadge(isActive: field.isActive),
                ],
              ),
              if (field.currentCrop != null || field.soilType != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (field.currentCrop != null) Expanded(child: _InfoChip(icon: Icons.eco, label: field.currentCrop!, color: AppTheme.primaryGreen)),
                    if (field.currentCrop != null && field.soilType != null) const SizedBox(width: 8),
                    if (field.soilType != null) Expanded(child: _InfoChip(icon: Icons.terrain, label: field.soilType!, color: Color(0xFF8b5cf6))),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.successColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: isActive ? AppTheme.successColor : Colors.grey,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}