import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/address_providers.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:pizza/shared/widgets/skeleton_loader.dart';
import 'package:pizza/data/models/address_models.dart';

/// Tela de Endereços
class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressesAsync = ref.watch(addressesProvider);
    final addressNotifier = ref.watch(addressNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addresses),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.profile);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRoutes.addAddress),
            tooltip: 'Adicionar endereço',
          ),
        ],
      ),
      body: addressesAsync.when(
        data: (addresses) {
          if (addresses.isEmpty) {
            return _buildEmptyState(context);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length,
            itemBuilder: (context, index) => _AddressCard(
              address: addresses[index],
              onEdit: () => context.push('${AppRoutes.editAddress}/${addresses[index].id}'),
              onDelete: () => _confirmDeleteAddress(context, addressNotifier, addresses[index]),
              onSetDefault: () => addressNotifier.setDefaultAddress(addresses[index].id),
            ),
          );
        },
        loading: () => _buildAddressesSkeleton(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar endereços',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.error,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => ref.invalidate(addressesProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on_outlined, size: 80, color: AppColors.textDisabled),
          const SizedBox(height: 16),
          Text(
            'Nenhum endereço cadastrado',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
        ),
          const SizedBox(height: 8),
          Text(
            'Adicione um endereço para facilitar suas entregas',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textDisabled,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: AppStrings.addAddress,
            isFullWidth: false,
            icon: Icons.add_location,
            onPressed: () => context.push(AppRoutes.addAddress),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAddress(BuildContext context, AddressNotifier notifier, AddressDto address) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir endereço'),
        content: Text('Tem certeza que deseja excluir "${address.label}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              notifier.deleteAddress(address.id);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressesSkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => _AddressSkeletonCard(),
    );
  }
}

class _AddressSkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SkeletonText(lines: 1, width: 100, height: 18),
                          const SizedBox(width: 8),
                          SkeletonLoader.rectangular(
                            width: 50,
                            height: 16,
                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SkeletonText(lines: 1, width: 200, height: 16),
                      SkeletonText(lines: 1, width: 180, height: 14),
                      SkeletonText(lines: 1, width: 120, height: 14),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SkeletonLoader.rectangular(width: 40, height: 40, borderRadius: BorderRadius.circular(8)),
                    SkeletonLoader.rectangular(width: 40, height: 40, borderRadius: BorderRadius.circular(8)),
                    SkeletonLoader.rectangular(width: 40, height: 40, borderRadius: BorderRadius.circular(8)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final AddressDto address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const _AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            address.label,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (address.isDefault) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Padrão',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${address.street}, ${address.number}${address.complement.isNotEmpty ? ', ${address.complement}' : ''}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      Text(
                        '${address.neighborhood}, ${address.city} - ${address.state}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                          ),
                      ),
                      Text(
                        'CEP: ${address.zipCode}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textDisabled,
                          ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    if (!address.isDefault)
                      IconButton(
                        icon: Icon(Icons.star_outline, color: AppColors.warning),
                        onPressed: onSetDefault,
                        tooltip: 'Definir como padrão',
                      ),
                    IconButton(
                      icon: Icon(Icons.edit_outlined, color: AppColors.primary),
                      onPressed: onEdit,
                      tooltip: 'Editar',
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: AppColors.error),
                      onPressed: onDelete,
                      tooltip: 'Excluir',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}