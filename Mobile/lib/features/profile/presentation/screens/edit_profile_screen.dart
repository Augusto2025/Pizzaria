import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/providers/auth_providers.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:pizza/shared/widgets/custom_text_field.dart';
import 'package:pizza/data/models/auth_models.dart';

/// Tela de Edição de Perfil
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmNewPasswordController;

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isChangingPassword = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(currentUserProvider);
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    final currentUserNotifier = ref.read(currentUserProvider.notifier);

    // Se está alterando senha, valida senha atual
    if (_isChangingPassword) {
      if (_currentPasswordController.text.isEmpty) {
        _showError('Informe a senha atual para confirmar a alteração');
        return;
      }
      if (_newPasswordController.text != _confirmNewPasswordController.text) {
        _showError('As novas senhas não coincidem');
        return;
      }
    }

    // Prepara request
    final request = UpdateProfileRequest(
      userId: currentUser.id,
      name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : null,
      phone: _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null,
      currentPassword: _isChangingPassword ? _currentPasswordController.text : null,
      newPassword: _isChangingPassword && _newPasswordController.text.isNotEmpty ? _newPasswordController.text : null,
      confirmNewPassword: _isChangingPassword && _confirmNewPasswordController.text.isNotEmpty ? _confirmNewPasswordController.text : null,
    );

    try {
      await currentUserNotifier.updateProfile(request);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Perfil atualizado com sucesso'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        _showError('Erro ao atualizar perfil: $e');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.editProfile),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: isLoading ? null : () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                      child: Text(
                        _nameController.text.isNotEmpty
                            ? _nameController.text[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Editar perfil',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Altere suas informações abaixo',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Informações Pessoais
              Text(
                'Informações Pessoais',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Nome
              CustomTextField(
                controller: _nameController,
                label: AppStrings.name,
                hint: 'Seu nome completo',
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  if (value.trim().split(' ').length < 2) {
                    return 'Informe nome completo (pelo menos 2 palavras)';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Telefone
              CustomTextField(
                controller: _phoneController,
                label: AppStrings.phone,
                hint: '(11) 99999-9999',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Telefone é obrigatório';
                  }
                  // Validação simples de telefone brasileiro
                  final digits = value.replaceAll(RegExp(r'[^\d]'), '');
                  if (digits.length < 10 || digits.length > 11) {
                    return 'Telefone inválido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Email (somente leitura - informativo)
              Text(
                'Email (não pode ser alterado)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(Icons.email_outlined, color: AppColors.textSecondary, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        currentUser?.email ?? '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                    Icon(Icons.lock_outline, size: 18, color: AppColors.textDisabled),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Alterar Senha
              Text(
                'Alterar Senha',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Toggle para mostrar campos de senha
              InkWell(
                onTap: () => setState(() => _isChangingPassword = !_isChangingPassword),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isChangingPassword
                        ? AppColors.primary.withValues(alpha: 0.05)
                        : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isChangingPassword ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isChangingPassword ? Icons.lock_outline : Icons.lock_open_outlined,
                        color: _isChangingPassword ? AppColors.primary : AppColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _isChangingPassword ? 'Alterar senha' : 'Clique para alterar senha',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: _isChangingPassword ? AppColors.textPrimary : AppColors.textSecondary,
                                fontWeight: _isChangingPassword ? FontWeight.w600 : FontWeight.normal,
                              ),
                        ),
                      ),
                      Icon(
                        _isChangingPassword ? Icons.expand_less : Icons.expand_more,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),

              // Campos de senha (condicionais)
              if (_isChangingPassword) ...[
                const SizedBox(height: 16),

                // Senha Atual
                CustomTextField(
                  controller: _currentPasswordController,
                  label: 'Senha atual',
                  hint: '••••••••',
                  obscureText: _obscureCurrentPassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrentPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
                  ),
                  validator: (value) {
                    if (_isChangingPassword && (value == null || value.isEmpty)) {
                      return 'Senha atual é obrigatória';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Nova Senha
                CustomTextField(
                  controller: _newPasswordController,
                  label: 'Nova senha',
                  hint: '••••••••',
                  obscureText: _obscureNewPassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                  ),
                  validator: (value) {
                    if (_isChangingPassword && value != null && value.isNotEmpty && value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Confirmar Nova Senha
                CustomTextField(
                  controller: _confirmNewPasswordController,
                  label: 'Confirmar nova senha',
                  hint: '••••••••',
                  obscureText: _obscureConfirmPassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  validator: (value) {
                    if (_isChangingPassword && value != _newPasswordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
              ],

              const SizedBox(height: 32),

              // Botão Salvar
              CustomButton(
                text: AppStrings.save,
                isLoading: isLoading,
                onPressed: _handleSave,
              ),

              const SizedBox(height: 16),

              // Botão Cancelar
              TextButton(
                onPressed: isLoading ? null : () => context.pop(),
                child: Text(
                  AppStrings.cancel,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  UserDto? get currentUser => ref.read(currentUserProvider);
}