import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/shared/widgets/custom_button.dart';

/// Tela do Carrinho
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock cart items
    final cartItems = _getMockCartItems();
    final subtotal = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    const deliveryFee = 5.90;
    final total = subtotal + deliveryFee;

    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(AppStrings.cart)),
        body: Center(
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
        ),
      );
    }

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
            onPressed: () {
              // TODO: Limpar carrinho
            },
            child: Text(
              AppStrings.clearCart,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) => _CartItemCard(
                item: cartItems[index],
                onQuantityChanged: (newQty) {
                  // TODO: Atualizar quantidade
                },
                onRemove: () {
                  // TODO: Remover item
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
      ),
    );
  }

  List<_CartItem> _getMockCartItems() {
    return [
      _CartItem(
        id: '1',
        name: 'Pizza Margherita',
        description: 'Molho de tomate, mussarela, manjericão',
        price: 42.90,
        quantity: 1,
        imageUrl: 'https://picsum.photos/seed/pizza1/100/100',
      ),
      _CartItem(
        id: '2',
        name: 'Coca-Cola 2L',
        description: '',
        price: 12.90,
        quantity: 2,
        imageUrl: 'https://picsum.photos/seed/drink1/100/100',
      ),
    ];
  }
}

class _CartItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;

  const _CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  double get totalPrice => price * quantity;
}

class _CartItemCard extends StatelessWidget {
  final _CartItem item;
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
                item.imageUrl,
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
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (item.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${item.price.toStringAsFixed(2).replaceAll('.', ',')}',
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
                  'R\$ ${item.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
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