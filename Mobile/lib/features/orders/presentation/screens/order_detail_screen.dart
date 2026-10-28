import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/shared/models/order_models.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:intl/intl.dart';

/// Tela de Detalhes do Pedido + Rastreamento
class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock order data
    final order = _getMockOrder(widget.orderId);
    final formatter = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');

    return Scaffold(
      appBar: AppBar(
        title: Text('$AppStrings.orderNumber ${order.id}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Compartilhar pedido
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Timeline
            _buildStatusTimeline(order),

            const SizedBox(height: 24),

            // Order Info
            _buildOrderInfo(order, formatter),

            const SizedBox(height: 24),

            // Items
            _buildItemsSection(order),

            const SizedBox(height: 24),

            // Payment & Address
            _buildPaymentAddressSection(order),

            const SizedBox(height: 24),

            // Actions
            if (order.status != OrderStatus.delivered && order.status != OrderStatus.cancelled)
              _buildActionsSection(order),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(_MockOrderDetail order) {
    final statuses = [
      OrderStatus.pending,
      OrderStatus.confirmed,
      OrderStatus.preparing,
      OrderStatus.baking,
      OrderStatus.ready,
      OrderStatus.outForDelivery,
      OrderStatus.delivered,
    ];

    final currentIndex = statuses.indexOf(order.status);
    final isCancelled = order.status == OrderStatus.cancelled;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timeline, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  AppStrings.trackOrder,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            if (!isCancelled) ...[
              const SizedBox(height: 20),
              ...statuses.asMap().entries.map((entry) {
                final index = entry.key;
                final status = entry.value;
                final isCompleted = index < currentIndex;
                final isCurrent = index == currentIndex;
                final isLast = index == statuses.length - 1;

                return _TimelineStep(
                  status: status,
                  isCompleted: isCompleted,
                  isCurrent: isCurrent,
                  isLast: isLast,
                  time: _getStatusTime(order, status),
                );
              }),
            ] else ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.cancel_outlined, color: AppColors.error, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pedido Cancelado',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Este pedido foi cancelado. Entre em contato se tiver dúvidas.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  DateTime? _getStatusTime(_MockOrderDetail order, OrderStatus status) {
    // Mock times for each status
    final baseTime = order.createdAt;
    switch (status) {
      case OrderStatus.pending:
        return baseTime;
      case OrderStatus.confirmed:
        return baseTime.add(const Duration(minutes: 5));
      case OrderStatus.preparing:
        return baseTime.add(const Duration(minutes: 15));
      case OrderStatus.baking:
        return baseTime.add(const Duration(minutes: 25));
      case OrderStatus.ready:
        return baseTime.add(const Duration(minutes: 35));
      case OrderStatus.outForDelivery:
        return baseTime.add(const Duration(minutes: 40));
      case OrderStatus.delivered:
        return order.estimatedDelivery;
      case OrderStatus.cancelled:
        return null;
    }
  }

  Widget _buildOrderInfo(_MockOrderDetail order, DateFormat formatter) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações do Pedido',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _InfoRow(label: AppStrings.orderDate, value: formatter.format(order.createdAt)),
            _InfoRow(label: AppStrings.estimatedDelivery, value: formatter.format(order.estimatedDelivery)),
            _InfoRow(label: AppStrings.deliveryAddressLabel, value: order.address),
            _InfoRow(label: AppStrings.paymentMethodLabel, value: order.paymentMethod),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsSection(_MockOrderDetail order) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$AppStrings.items (${order.items.length})',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...order.items.map((item) => _OrderItemRow(item: item)),
            const Divider(height: 24),
            _InfoRow(
              label: AppStrings.subtotal,
              value: 'R\$ ${order.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
            ),
            _InfoRow(
              label: AppStrings.deliveryFee,
              value: 'R\$ ${order.deliveryFee.toStringAsFixed(2).replaceAll('.', ',')}',
            ),
            const Divider(height: 16),
            _InfoRow(
              label: AppStrings.total,
              value: 'R\$ ${order.total.toStringAsFixed(2).replaceAll('.', ',')}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentAddressSection(_MockOrderDetail order) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pagamento e Entrega',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _InfoRow(label: AppStrings.paymentMethodLabel, value: order.paymentMethod),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined, size: 20, color: AppColors.textSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.deliveryAddressLabel,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order.address,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection(_MockOrderDetail order) {
    return Column(
      children: [
        if (order.status != OrderStatus.pending)
          CustomButton(
            text: AppStrings.reorder,
            isOutlined: true,
            onPressed: () {
              // TODO: Reorder
            },
          ),
        const SizedBox(height: 12),
        CustomButton(
          text: AppStrings.cancelOrder,
          isOutlined: true,
          backgroundColor: AppColors.error.withValues(alpha: 0.1),
          foregroundColor: AppColors.error,
          onPressed: () => _showCancelDialog(context, order),
        ),
      ],
    );
  }

  void _showCancelDialog(BuildContext context, _MockOrderDetail order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.cancelOrder),
        content: Text(AppStrings.confirmCancel),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Cancel order
            },
            child: Text(AppStrings.confirm, style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  _MockOrderDetail _getMockOrder(String orderId) {
    return _MockOrderDetail(
      id: orderId,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      status: OrderStatus.preparing,
      estimatedDelivery: DateTime.now().add(const Duration(minutes: 30)),
      subtotal: 95.70,
      deliveryFee: 5.90,
      total: 101.60,
      address: 'Rua das Flores, 123 - Centro, São Paulo/SP',
      paymentMethod: 'PIX',
      items: [
        _MockOrderItem(name: 'Pizza Margherita', quantity: 1, price: 42.90),
        _MockOrderItem(name: 'Pizza Pepperoni', quantity: 1, price: 48.90),
        _MockOrderItem(name: 'Coca-Cola 2L', quantity: 1, price: 12.90),
      ],
    );
  }
}

class _TimelineStep extends StatefulWidget {
  final OrderStatus status;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;
  final DateTime? time;

  const _TimelineStep({
    required this.status,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLast,
    this.time,
  });

  @override
  State<_TimelineStep> createState() => _TimelineStepState();
}

class _TimelineStepState extends State<_TimelineStep> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('HH:mm', 'pt_BR');
    final status = widget.status;
    final isCompleted = widget.isCompleted;
    final isCurrent = widget.isCurrent;
    final isLast = widget.isLast;
    final time = widget.time;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line & circle
        Column(
          children: [
            // Circle
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted || isCurrent ? status.color : AppColors.surface,
                border: Border.all(
                  color: isCompleted || isCurrent ? status.color : AppColors.border,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            // Line
            if (!isLast)
              Expanded(
                child: Container(
                  width: 2,
                  color: isCompleted ? status.color : AppColors.border,
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      status.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                            color: isCompleted || isCurrent ? status.color : AppColors.textSecondary,
                          ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 8),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: status.color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'AGORA',
                              style: TextStyle(
                                color: status.color,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
                if (time != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    formatter.format(time),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textDisabled,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final _MockOrderItem item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  'Qtd: ${item.quantity}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Text(
            'R\$ ${(item.price * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}

class _MockOrderItem {
  final String name;
  final int quantity;
  final double price;

  const _MockOrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class _MockOrderDetail {
  final String id;
  final DateTime createdAt;
  final OrderStatus status;
  final DateTime estimatedDelivery;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String address;
  final String paymentMethod;
  final List<_MockOrderItem> items;

  const _MockOrderDetail({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.estimatedDelivery,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.items,
  });
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
                    fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isTotal ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}