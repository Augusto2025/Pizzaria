import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/shared/models/order_models.dart';
import 'package:intl/intl.dart';

/// Tela de Lista de Pedidos
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = _getMockOrders();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.orders),
      ),
      body: orders.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) => _OrderCard(
                order: orders[index],
                onTap: () => context.push('${AppRoutes.orderDetail}/${orders[index].id}'),
              ),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: AppColors.textDisabled),
          const SizedBox(height: 16),
          Text(
            AppStrings.noOrdersYet,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
        ),
          const SizedBox(height: 8),
          Text(
            AppStrings.makeFirstOrder,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textDisabled,
                ),
        ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go(AppRoutes.menu),
            icon: const Icon(Icons.restaurant_menu),
            label: Text(AppStrings.orderNow),
          ),
        ],
      ),
    );
  }

  List<_MockOrder> _getMockOrders() {
    return [
      _MockOrder(
        id: 'ORD-2024-001',
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: OrderStatus.delivered,
        total: 112.60,
        itemsCount: 3,
        estimatedDelivery: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      _MockOrder(
        id: 'ORD-2024-002',
        date: DateTime.now().subtract(const Duration(days: 3)),
        status: OrderStatus.delivered,
        total: 89.90,
        itemsCount: 2,
        estimatedDelivery: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
      ),
      _MockOrder(
        id: 'ORD-2024-003',
        date: DateTime.now().subtract(const Duration(days: 7)),
        status: OrderStatus.cancelled,
        total: 65.00,
        itemsCount: 1,
        estimatedDelivery: null,
      ),
    ];
  }
}

class _MockOrder {
  final String id;
  final DateTime date;
  final OrderStatus status;
  final double total;
  final int itemsCount;
  final DateTime? estimatedDelivery;

  const _MockOrder({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.itemsCount,
    this.estimatedDelivery,
  });
}

class _OrderCard extends StatelessWidget {
  final _MockOrder order;
  final VoidCallback onTap;

  const _OrderCard({required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      order.id,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: order.status.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status.label,
                      style: TextStyle(
                        color: order.status.color,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                formatter.format(order.date),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.fastfood,
                    label: '${order.itemsCount} ${order.itemsCount == 1 ? 'item' : 'itens'}',
                  ),
                  _InfoChip(
                    icon: Icons.attach_money,
                    label: 'R\$ ${order.total.toStringAsFixed(2).replaceAll('.', ',')}',
                  ),
                  if (order.estimatedDelivery != null)
                    _InfoChip(
                      icon: Icons.access_time,
                      label: 'Entregue ${formatter.format(order.estimatedDelivery!)}',
                    ),
                ],
              ),
              if (order.status.isActive) ...[
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Text(
                  'Toque para acompanhar',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}