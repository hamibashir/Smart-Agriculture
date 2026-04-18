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
  int? _deletingFieldId;
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
    if (result == true) await _loadFields();
  }

  Future<void> _openFieldDetails(Field field) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FieldDetailScreen(field: field)),
    );
    await _loadFields();
  }

  Future<bool> _confirmDeleteField(Field field) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Field'),
        content: Text('Delete "${field.fieldName}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppTheme.errorColor),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return false;

    setState(() => _deletingFieldId = field.fieldId);

    try {
      final response = await _apiService.deleteField(field.fieldId);

      if (!mounted) return false;

      if (response['success'] == true) {
        setState(() {
          _fields.removeWhere((item) => item.fieldId == field.fieldId);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Field deleted successfully'),
            backgroundColor: AppTheme.successColor,
          ),
        );

        return true;
      }
    } catch (_) {
      if (!mounted) return false;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete field'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _deletingFieldId = null);
      }
    }

    return false;
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
                        itemBuilder: (_, index) => _FieldCard(
                          field: _fields[index],
                          isDeleting: _deletingFieldId == _fields[index].fieldId,
                          onTap: () => _openFieldDetails(_fields[index]),
                          onDelete: () => _confirmDeleteField(_fields[index]),
                        ),
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
  const _FieldCard({
    required this.field,
    required this.isDeleting,
    required this.onTap,
    required this.onDelete,
  });

  final Field field;
  final bool isDeleting;
  final VoidCallback onTap;
  final Future<bool> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(field.fieldId),
      direction: isDeleting ? DismissDirection.none : DismissDirection.endToStart,
      confirmDismiss: (_) => onDelete(),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete_outline, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Delete',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: isDeleting ? null : onTap,
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
                        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
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
                    if (isDeleting)
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
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
                      if (field.soilType != null) Expanded(child: _InfoChip(icon: Icons.terrain, label: field.soilType!, color: const Color(0xFF8b5cf6))),
                    ],
                  ),
                ],
              ],
            ),
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
        color: isActive ? AppTheme.successColor.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
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
