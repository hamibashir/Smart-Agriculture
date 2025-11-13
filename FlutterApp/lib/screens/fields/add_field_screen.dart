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
  final _soilTypeController = TextEditingController();
  final _currentCropController = TextEditingController();
  
  String _areaUnit = 'acres';
  bool _isLoading = false;

  @override
  void dispose() {
    _fieldNameController.dispose();
    _areaSizeController.dispose();
    _soilTypeController.dispose();
    _currentCropController.dispose();
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
        'soil_type': _soilTypeController.text.trim().isEmpty 
            ? null 
            : _soilTypeController.text.trim(),
        'current_crop': _currentCropController.text.trim().isEmpty 
            ? null 
            : _currentCropController.text.trim(),
      });

      if (response['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Field added successfully'),
              backgroundColor: AppTheme.successColor,
            ),
          );
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add field: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Field'),
      ),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter field name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _areaSizeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Area Size *',
                        prefixIcon: Icon(Icons.square_foot),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _areaUnit,
                      decoration: const InputDecoration(
                        labelText: 'Unit',
                      ),
                      items: const [
                        DropdownMenuItem(value: 'acres', child: Text('Acres')),
                        DropdownMenuItem(value: 'hectares', child: Text('Hectares')),
                        DropdownMenuItem(value: 'square_meters', child: Text('Sq. Meters')),
                      ],
                      onChanged: (value) {
                        setState(() => _areaUnit = value!);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _soilTypeController,
                decoration: const InputDecoration(
                  labelText: 'Soil Type (Optional)',
                  hintText: 'e.g., Clay, Sandy, Loamy',
                  prefixIcon: Icon(Icons.terrain),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _currentCropController,
                decoration: const InputDecoration(
                  labelText: 'Current Crop (Optional)',
                  hintText: 'e.g., Wheat, Rice, Cotton',
                  prefixIcon: Icon(Icons.eco),
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
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
