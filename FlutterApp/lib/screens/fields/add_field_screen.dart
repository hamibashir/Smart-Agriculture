import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../config/app_theme.dart';

class AddFieldScreen extends StatefulWidget {
  const AddFieldScreen({super.key});

  @override
  State<AddFieldScreen> createState() => _AddFieldScreenState();
}

class _AddFieldScreenState extends State<AddFieldScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  final _fieldNameController = TextEditingController();
  final _areaSizeController = TextEditingController();
  String? _soilType;
  String? _currentCrop;

  String _areaUnit = 'acres';
  bool _isLoading = false;

  @override
  void dispose() {
    _fieldNameController.dispose();
    _areaSizeController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _apiService.createField({
        'field_name': _fieldNameController.text.trim(),
        'area_size': double.parse(_areaSizeController.text),
        'area_unit': _areaUnit,
        'soil_type': _soilType,
        'current_crop': _currentCrop,
      });

      if (response['success'] == true) {
        if (!mounted) return;
        _showSnackBar('Field added successfully', AppTheme.successColor);
        Navigator.pop(context, true);
      }
    } catch (_) {
      _showSnackBar('Failed to add field', AppTheme.errorColor);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Field')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _fieldNameController,
                decoration: const InputDecoration(
                  labelText: 'Field Name *',
                  hintText: 'e.g., North Field',
                  prefixIcon: Icon(Icons.grass),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter field name' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _areaSizeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Area Size *',
                        prefixIcon: Icon(Icons.square_foot),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (double.tryParse(value) == null) return 'Invalid number';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      key: ValueKey(_areaUnit),
                      initialValue: _areaUnit,
                      decoration: const InputDecoration(labelText: 'Unit'),
                      items: const [
                        DropdownMenuItem(value: 'acres', child: Text('Acres')),
                        DropdownMenuItem(value: 'hectares', child: Text('Hectares')),
                        DropdownMenuItem(value: 'square_meters', child: Text('Sq. Meters')),
                      ],
                      onChanged: (value) => setState(() => _areaUnit = value!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _soilType,
                decoration: const InputDecoration(
                  labelText: 'Soil Type *',
                  prefixIcon: Icon(Icons.terrain),
                ),
                items: const [
                  DropdownMenuItem(value: 'loamy', child: Text('Loamy')),
                  DropdownMenuItem(value: 'clay_loam', child: Text('Clay Loam')),
                  DropdownMenuItem(value: 'silty', child: Text('Silty')),
                  DropdownMenuItem(value: 'clay', child: Text('Clay')),
                  DropdownMenuItem(value: 'sandy', child: Text('Sandy')),
                ],
                onChanged: (value) => setState(() => _soilType = value),
                validator: (value) => value == null ? 'Please select soil type' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _currentCrop,
                decoration: const InputDecoration(
                  labelText: 'Current Crop *',
                  prefixIcon: Icon(Icons.eco),
                ),
                items: const [
                  DropdownMenuItem(value: 'wheat', child: Text('Wheat')),
                  DropdownMenuItem(value: 'rice', child: Text('Rice')),
                  DropdownMenuItem(value: 'cotton', child: Text('Cotton')),
                  DropdownMenuItem(value: 'maize', child: Text('Maize')),
                  DropdownMenuItem(value: 'sugarcane', child: Text('Sugarcane')),
                  DropdownMenuItem(value: 'mustard', child: Text('Mustard')),
                  DropdownMenuItem(value: 'chickpea', child: Text('Chickpea')),
                  DropdownMenuItem(value: 'sunflower', child: Text('Sunflower')),
                ],
                onChanged: (value) => setState(() => _currentCrop = value),
                validator: (value) => value == null ? 'Please select current crop' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                      )
                    : const Text('Add Field'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
