import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/address_providers.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:pizza/shared/widgets/custom_text_field.dart';
import 'package:pizza/shared/widgets/skeleton_loader.dart';
import 'package:pizza/data/models/address_models.dart';

/// Tela de Adicionar/Editar Endereço
class AddEditAddressScreen extends ConsumerStatefulWidget {
  final String? addressId;

  const AddEditAddressScreen({super.key, this.addressId});

  @override
  ConsumerState<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends ConsumerState<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  bool _isDefault = false;
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.addressId != null;
    if (_isEditing) {
      _loadAddress();
    }
  }

  Future<void> _loadAddress() async {
    final address = await ref.read(addressProvider(widget.addressId!).future);
    if (address != null && mounted) {
      setState(() {
        _labelController.text = address.label;
        _streetController.text = address.street;
        _numberController.text = address.number;
        _complementController.text = address.complement;
        _neighborhoodController.text = address.neighborhood;
        _cityController.text = address.city;
        _stateController.text = address.state;
        _zipCodeController.text = address.zipCode;
        _isDefault = address.isDefault;
      });
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final request = CreateAddressRequest(
      label: _labelController.text.trim(),
      street: _streetController.text.trim(),
      number: _numberController.text.trim(),
      complement: _complementController.text.trim().isEmpty ? null : _complementController.text.trim(),
      neighborhood: _neighborhoodController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim().toUpperCase(),
      zipCode: _zipCodeController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      latitude: 0,
      longitude: 0,
      isDefault: _isDefault,
    );

    try {
      final notifier = ref.read(addressNotifierProvider.notifier);
      if (_isEditing) {
        final updateRequest = UpdateAddressRequest(
          id: widget.addressId!,
          label: request.label,
          street: request.street,
          number: request.number,
          complement: request.complement,
          neighborhood: request.neighborhood,
          city: request.city,
          state: request.state,
          zipCode: request.zipCode,
          latitude: request.latitude,
          longitude: request.longitude,
          isDefault: request.isDefault,
        );
        await notifier.updateAddress(widget.addressId!, updateRequest);
      } else {
        await notifier.createAddress(request);
      }

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar endereço: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show skeleton loading when editing and loading address data
    if (_isEditing && _labelController.text.isEmpty && !_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Endereço'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.addresses);
              }
            },
          ),
        ),
        body: _buildSkeletonLoading(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Endereço' : 'Novo Endereço'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.addresses);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Label Field
              CustomTextField(
                controller: _labelController,
                label: 'Rótulo',
                hint: 'Ex: Casa, Trabalho, Mãe',
                prefixIcon: Icons.label_outline,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um rótulo';
                  }
                  if (value.length > 50) {
                    return 'Rótulo muito longo (máx. 50 caracteres)';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // CEP Field
              CustomTextField(
                controller: _zipCodeController,
                label: 'CEP',
                hint: '00000-000',
                prefixIcon: Icons.location_on_outlined,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o CEP';
                  }
                  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (digits.length != 8) {
                    return 'CEP inválido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Street Field
              CustomTextField(
                controller: _streetController,
                label: 'Rua/Avenida',
                hint: 'Ex: Rua das Flores',
                prefixIcon: Icons.streetview_outlined,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a rua';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Number Field
              CustomTextField(
                controller: _numberController,
                label: 'Número',
                hint: 'Ex: 123',
                prefixIcon: Icons.numbers_outlined,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o número';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Complement Field
              CustomTextField(
                controller: _complementController,
                label: 'Complemento (opcional)',
                hint: 'Ex: Apto 101, Bloco B',
                prefixIcon: Icons.apartment_outlined,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 16),

              // Neighborhood Field
              CustomTextField(
                controller: _neighborhoodController,
                label: 'Bairro',
                hint: 'Ex: Centro',
                prefixIcon: Icons.map_outlined,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o bairro';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // City Field
              CustomTextField(
                controller: _cityController,
                label: 'Cidade',
                hint: 'Ex: São Paulo',
                prefixIcon: Icons.location_city_outlined,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a cidade';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // State Field
              CustomTextField(
                controller: _stateController,
                label: 'Estado (UF)',
                hint: 'Ex: SP',
                prefixIcon: Icons.flag_outlined,
                textInputAction: TextInputAction.done,
                maxLength: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o estado';
                  }
                  if (value.length != 2) {
                    return 'Use a sigla do estado (ex: SP)';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Default Address Switch
              SwitchListTile(
                title: Text(
                  'Definir como endereço padrão',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                subtitle: Text(
                  'Este endereço será usado automaticamente nos pedidos',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                value: _isDefault,
                onChanged: (value) => setState(() => _isDefault = value),
                activeThumbColor: AppColors.primary,
              ),

              const SizedBox(height: 32),

              // Save Button
              CustomButton(
                text: _isEditing ? 'Salvar Alterações' : 'Adicionar Endereço',
                isLoading: _isLoading,
                icon: Icons.save,
                onPressed: _handleSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
  }

  Widget _buildSkeletonLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Label Field skeleton
          SkeletonText(lines: 1, width: double.infinity, height: 56),
          const SizedBox(height: 16),
          // CEP Field skeleton
          SkeletonText(lines: 1, width: double.infinity, height: 56),
          const SizedBox(height: 16),
          // Street Field skeleton
          SkeletonText(lines: 1, width: double.infinity, height: 56),
          const SizedBox(height: 16),
          // Number Field skeleton
          SkeletonText(lines: 1, width: double.infinity, height: 56),
          const SizedBox(height: 16),
          // Complement Field skeleton
          SkeletonText(lines: 1, width: double.infinity, height: 56),
          const SizedBox(height: 16),
          // Neighborhood Field skeleton
          SkeletonText(lines: 1, width: double.infinity, height: 56),
          const SizedBox(height: 16),
          // City Field skeleton
          SkeletonText(lines: 1, width: double.infinity, height: 56),
          const SizedBox(height: 16),
          // State Field skeleton
          SkeletonText(lines: 1, width: double.infinity, height: 56),
          const SizedBox(height: 24),
          // Default Address Switch skeleton
          Row(
            children: [
              SkeletonLoader.rectangular(width: 40, height: 24, borderRadius: BorderRadius.circular(12)),
              const SizedBox(width: 16),
              Expanded(child: SkeletonText(lines: 2, height: 16)),
            ],
          ),
          const SizedBox(height: 32),
          // Save Button skeleton
          SkeletonLoader.rectangular(
            width: double.infinity,
            height: 48,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
    );
  }
}