import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/auth_providers.dart';
import 'package:pizza/core/providers/order_providers.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:pizza/data/models/auth_models.dart';

/// Tela de Perfil do Usuário
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.profile)),
      body: currentUser == null
          ? _buildLoadingState(context)
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), // Bottom padding for NavigationBar
              child: Column(
                children: [
                  // User Info Card
                  _buildUserInfoCard(context, ref, currentUser),

                  const SizedBox(height: 24),

                  // Menu Options
                  _buildMenuOptions(context),

                  const SizedBox(height: 24),

                  // Logout Button
                  CustomButton(
                    text: AppStrings.logout,
                    isOutlined: true,
                    backgroundColor: AppColors.error.withValues(alpha: 0.1),
                    foregroundColor: AppColors.error,
                    isLoading: authState.isLoading,
                    onPressed: () => _showLogoutDialog(context, ref),
                  ),

                  const SizedBox(height: 16),

                  // Delete Account
                  TextButton(
                    onPressed: () => _showDeleteAccountDialog(context, ref),
                    child: Text(
                      AppStrings.deleteAccount,
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildUserInfoCard(BuildContext context, WidgetRef ref, UserDto user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email_outlined, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(user.email, style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone_outlined, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(user.phone, style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: AppStrings.editProfile,
              isOutlined: true,
              isFullWidth: false,
              onPressed: () => context.push(AppRoutes.editProfile),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOptions(BuildContext context) {
    final options = [
      _ProfileOption(
        icon: Icons.location_on_outlined,
        title: AppStrings.addresses,
        subtitle: 'Gerenciar endereços de entrega',
        onTap: () => context.push(AppRoutes.addresses),
      ),
      _ProfileOption(
        icon: Icons.payment_outlined,
        title: AppStrings.paymentMethods,
        subtitle: 'Cartões e formas de pagamento',
        onTap: () => context.push(AppRoutes.paymentMethods),
      ),
      _ProfileOption(
        icon: Icons.history_outlined,
        title: AppStrings.orderHistory,
        subtitle: 'Ver todos os pedidos anteriores',
        onTap: () => context.push(AppRoutes.orders),
      ),
      _ProfileOption(
        icon: Icons.settings_outlined,
        title: AppStrings.settings,
        subtitle: 'Notificações, tema, privacidade',
        onTap: () => context.push(AppRoutes.settings),
      ),
    ];

    return Column(
      children: options.map((option) => _ProfileOptionTile(option: option)).toList(),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sair da conta'),
        content: const Text('Tem certeza que deseja sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir conta'),
        content: const Text('Esta ação é irreversível. Tem certeza?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              // TODO: Implementar exclusão de conta via API
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Funcionalidade em desenvolvimento')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class _ProfileOptionTile extends StatelessWidget {
  final _ProfileOption option;

  const _ProfileOptionTile({required this.option});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(option.icon, color: AppColors.primary, size: 22),
        ),
        title: Text(
          option.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          option.subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textDisabled),
        onTap: option.onTap,
      ),
    );
  }
}