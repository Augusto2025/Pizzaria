import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/providers/order_providers.dart';
import 'package:pizza/data/models/address_models.dart';
import 'package:pizza/data/models/order_models.dart';
import 'package:pizza/shared/widgets/custom_button.dart';

/// Tela de Detalhes do Pedido + Rastreamento
class OrderDetailScreen extends ConsumerStatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // Status values (matching backend)
  static const int statusPending = 0;
  static const int statusConfirmed = 1;
  static const int statusPreparing = 2;
  static const int statusBaking = 3;
  static const int statusReady = 4;
  static const int statusOutForDelivery = 5;
  static const int statusDelivered = 6;
  static const int statusCancelled = 7;

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
    final orderAsync = ref.watch(orderProvider(widget.orderId));
    final formatter = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');

    return Scaffold(
      appBar: AppBar(
        title: Text('$AppStrings.orderNumber ${widget.orderId}'),
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
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(orderProvider(widget.orderId)),
          ),
        ],
      ),
      body: orderAsync.when(
        data: (order) => SingleChildScrollView(
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
              _buildPaymentAddressSection(order, formatter),

              const SizedBox(height: 24),

              // Actions
              if (order.status.value < statusDelivered && order.status.value != statusCancelled)
                _buildActionsSection(order),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar pedido',
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
                onPressed: () => ref.invalidate(orderProvider(widget.orderId)),
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(OrderDto order) {
    final statuses = [
      _TimelineStatus(value: statusPending, label: 'Pendente', color: AppColors.statusPending),
      _TimelineStatus(value: statusConfirmed, label: 'Confirmado', color: AppColors.statusConfirmed),
      _TimelineStatus(value: statusPreparing, label: 'Preparando', color: AppColors.statusPreparing),
      _TimelineStatus(value: statusBaking, label: 'Assando', color: AppColors.statusBaking),
      _TimelineStatus(value: statusReady, label: 'Pronto', color: AppColors.statusReady),
      _TimelineStatus(value: statusOutForDelivery, label: 'Saiu para entrega', color: AppColors.statusOutForDelivery),
      _TimelineStatus(value: statusDelivered, label: 'Entregue', color: AppColors.statusDelivered),
    ];

    final currentIndex = statuses.indexWhere((s) => s.value == order.status.value);
    final isCancelled = order.status.value == statusCancelled;

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
                  time: _getStatusTime(order, status.value),
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

  DateTime? _getStatusTime(OrderDto order, int statusValue) {
    // Find the timeline entry for this status
    final timelineEntry = order.timeline.firstWhere(
      (t) => t.status.value == statusValue,
      orElse: () => null,
    );
    return timelineEntry?.timestamp;
  }

  Widget _buildOrderInfo(OrderDto order, DateFormat formatter) {
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
            if (order.estimatedDeliveryTime != null)
              _InfoRow(label: AppStrings.estimatedDelivery, value: formatter.format(order.estimatedDeliveryTime!)),
            _InfoRow(label: AppStrings.deliveryAddressLabel, value: _formatAddress(order.deliveryAddress)),
            _InfoRow(label: AppStrings.paymentMethodLabel, value: _getPaymentMethodLabel(order.paymentMethod)),
          ],
        ),
      ),
    );
  }

  String _formatAddress(AddressDto address) {
    return '${address.street}, ${address.number}${address.complement.isNotEmpty ? ', ${address.complement}' : ''} - ${address.neighborhood}, ${address.city} - ${address.state}';
  }

  String _getPaymentMethodLabel(int paymentMethod) {
    switch (paymentMethod) {
      case 0:
        return 'Dinheiro';
      case 1:
        return 'Cartão';
      case 2:
        return 'PIX';
      case 3:
        return 'Saldo do App';
      default:
        return 'Desconhecido';
    }
  }

  Widget _buildItemsSection(OrderDto order) {
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

  Widget _buildPaymentAddressSection(OrderDto order, DateFormat formatter) {
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
            _InfoRow(label: AppStrings.paymentMethodLabel, value: _getPaymentMethodLabel(order.paymentMethod)),
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
                        _formatAddress(order.deliveryAddress),
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

  Widget _buildActionsSection(OrderDto order) {
    return Column(
      children: [
        if (order.status.value != statusPending)
          CustomButton(
            text: AppStrings.reorder,
            isOutlined: true,
            onPressed: () async {
              await ref.read(orderNotifierProvider.notifier).reorder(order.id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Itens adicionados ao carrinho')),
                );
              }
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

  void _showCancelDialog(BuildContext context, OrderDto order) {
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
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(orderNotifierProvider.notifier).cancelOrder(order.id);
              if (mounted) {
                context.pop(); // Go back to orders list
              }
            },
            child: Text(AppStrings.confirm, style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _TimelineStatus {
  final int value;
  final String label;
  final Color color;

  const _TimelineStatus({
    required this.value,
    required this.label,
    required this.color,
  });
}

class _TimelineStep extends StatefulWidget {
  final _TimelineStatus status;
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
  final OrderItemDto item;

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
                  item.productName,
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
            'R\$ ${(item.unitPrice * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
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