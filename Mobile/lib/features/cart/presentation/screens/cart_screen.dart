import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/cart_providers.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:pizza/data/models/cart_models.dart';

/// Tela do Carrinho
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);
    final cartNotifier = ref.watch(cartNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.cart),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.menu);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => cartNotifier.clear(),
            child: Text(
              AppStrings.clearCart,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
      body: cartAsync.when(
        data: (cart) {
          final items = cart.items;
          final subtotal = cart.subtotal;
          const deliveryFee = 5.90;
          final total = subtotal + deliveryFee;

          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: AppColors.textDisabled),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.cartEmpty,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.addItems,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textDisabled,
                        ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: AppStrings.menu,
                    isFullWidth: false,
                    icon: Icons.restaurant_menu,
                    onPressed: () => context.go(AppRoutes.menu),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) => _CartItemCard(
                    item: items[index],
                    onQuantityChanged: (newQty) {
                      cartNotifier.updateItem(
                        items[index].id,
                        UpdateCartItemRequest(
                          quantity: newQty,
                          selectedCustomizations: null,
                          notes: null,
                        ),
                      );
                    },
                    onRemove: () {
                      cartNotifier.removeItem(items[index].id);
                    },
                  ),
                ),
              ),

              // Summary
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border(top: BorderSide(color: AppColors.divider)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _SummaryRow(label: AppStrings.subtotal, value: subtotal),
                    _SummaryRow(label: AppStrings.deliveryFee, value: deliveryFee),
                    const Divider(height: 16),
                    _SummaryRow(
                      label: AppStrings.total,
                      value: total,
                      isTotal: true,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: '${AppStrings.checkout} - R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                      icon: Icons.arrow_forward,
                      onPressed: () => context.push(AppRoutes.checkout),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar carrinho',
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
                onPressed: () => ref.invalidate(cartProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItemDto item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 70,
                  height: 70,
                  color: AppColors.surface,
                  child: const Icon(Icons.fastfood, color: AppColors.textDisabled),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (item.notes != null && item.notes!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.notes!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${item.product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                // Quantity controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 18),
                        onPressed: () {
                          if (item.quantity > 1) {
                            onQuantityChanged(item.quantity - 1);
                          } else {
                            onRemove();
                          }
                        },
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      ),
                      Text(
                        '${item.quantity}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        onPressed: () => onQuantityChanged(item.quantity + 1),
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Total price
                Text(
                  'R\$ ${(item.product.price * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = isTotal
        ? Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style?.copyWith(color: isTotal ? AppColors.textPrimary : AppColors.textSecondary)),
          Text(
            'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}',
            style: style?.copyWith(
              color: isTotal ? AppColors.primary : AppColors.textPrimary,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}