import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/providers/order_providers.dart';
import 'package:pizza/data/models/address_models.dart';
import 'package:pizza/data/models/order_models.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:pizza/shared/widgets/skeleton_loader.dart';

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
        title: Text('Pedido #${widget.orderId}'),
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
        loading: () => _buildOrderDetailSkeleton(),
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
                  'Acompanhar pedido',
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
                  order: order,
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
    final timelineEntry = order.timeline.where((t) => t.status.value == statusValue).firstOrNull;
    return timelineEntry?.timestamp;
  }

  String? _getTimelineNote(OrderDto order, int statusValue) {
    final timelineEntry = order.timeline.where((t) => t.status.value == statusValue).firstOrNull;
    return (timelineEntry?.note != null && timelineEntry!.note!.isNotEmpty) ? timelineEntry.note : null;
  }

  Widget _buildTimelineNoteForStatus(OrderDto order, int statusValue) {
    final note = _getTimelineNote(order, statusValue);
    if (note == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 40),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                note,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
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
            _InfoRow(label: 'Data do pedido', value: formatter.format(order.createdAt)),
            if (order.estimatedDeliveryTime != null)
              _InfoRow(label: 'Previsão de entrega', value: formatter.format(order.estimatedDeliveryTime!)),
            _InfoRow(label: 'Endereço de entrega', value: _formatAddress(order.deliveryAddress)),
            _InfoRow(label: 'Forma de pagamento', value: _getPaymentMethodLabel(order.paymentMethod)),
            if (order.notes != null && order.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Observações do Pedido',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  order.notes!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                ),
              ),
            ],
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
                  'Itens (${order.items.length})',
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
              label: 'Subtotal',
              value: 'R\$ ${order.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
            ),
            _InfoRow(
              label: 'Taxa de entrega',
              value: 'R\$ ${order.deliveryFee.toStringAsFixed(2).replaceAll('.', ',')}',
            ),
            const Divider(height: 16),
            _InfoRow(
              label: 'Total',
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
            _InfoRow(label: 'Forma de pagamento', value: _getPaymentMethodLabel(order.paymentMethod)),
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
                        'Endereço de entrega',
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
            text: 'Pedir novamente',
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
          text: 'Cancelar pedido',
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
        title: Text('Cancelar pedido'),
        content: Text('Tem certeza que deseja cancelar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(orderNotifierProvider.notifier).cancelOrder(order.id);
              if (mounted) {
                context.pop(); // Go back to orders list
              }
            },
            child: Text('Confirmar', style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailSkeleton() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Timeline skeleton
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonText(lines: 1, width: 150, height: 24),
                  const SizedBox(height: 20),
                  ...List.generate(7, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SkeletonLoader.circular(diameter: 24),
                            if (index < 6)
                              Expanded(child: Container(width: 2, color: AppColors.border)),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonText(lines: 1, width: 100, height: 18),
                              const SizedBox(height: 2),
                              SkeletonText(lines: 1, width: 80, height: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Order Info skeleton
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonText(lines: 1, width: 180, height: 22),
                  const SizedBox(height: 16),
                  ...List.generate(4, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        SizedBox(width: 120, child: SkeletonText(lines: 1, height: 16)),
                        Expanded(child: SkeletonText(lines: 1, height: 16)),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Items skeleton
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonText(lines: 1, width: 150, height: 22),
                  const SizedBox(height: 16),
                  ...List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(child: SkeletonText(lines: 2, height: 16)),
                        const SizedBox(width: 16),
                        SkeletonText(lines: 1, width: 80, height: 18),
                      ],
                    ),
                  )),
                  const Divider(height: 24),
                  ...List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        SizedBox(width: 120, child: SkeletonText(lines: 1, height: 16)),
                        Expanded(child: SkeletonText(lines: 1, height: 16)),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Payment & Address skeleton
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonText(lines: 1, width: 180, height: 22),
                  const SizedBox(height: 16),
                  ...List.generate(2, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        SizedBox(width: 120, child: SkeletonText(lines: 1, height: 16)),
                        Expanded(child: SkeletonText(lines: 1, height: 16)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLoader.circular(diameter: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonText(lines: 1, height: 14),
                            const SizedBox(height: 2),
                            SkeletonText(lines: 2, height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Actions skeleton
          Column(
            children: [
              SkeletonLoader.rectangular(
                width: double.infinity,
                height: 48,
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(height: 12),
              SkeletonLoader.rectangular(
                width: double.infinity,
                height: 48,
                borderRadius: BorderRadius.circular(12),
              ),
            ],
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
  final OrderDto order;

  const _TimelineStep({
    required this.status,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLast,
    this.time,
    required this.order,
  });

  @override
  State<_TimelineStep> createState() => _TimelineStepState();
}

class _TimelineStepState extends State<_TimelineStep> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  String? _getTimelineNoteInline(OrderDto order, int statusValue) {
    final timelineEntry = order.timeline.where((t) => t.status.value == statusValue).firstOrNull;
    final note = timelineEntry?.note;
    return (note != null && note.isNotEmpty) ? note : null;
  }

  Widget _buildTimelineNoteForStatusInline(OrderDto order, int statusValue) {
    final note = _getTimelineNoteInline(order, statusValue);
    if (note == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 40),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                note,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
    final order = widget.order;

    // IntrinsicHeight resolve "RenderFlex children have non-zero flex but incoming height constraints are unbounded"
    // O Expanded na coluna da linha do timeline precisa de altura finita
    return IntrinsicHeight(
      child: Row(
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
                  // Timeline note (if any)
                  if (widget.status.value == order.status.value || widget.isCompleted) ...[
                    _buildTimelineNoteForStatusInline(order, widget.status.value),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );  // fecha IntrinsicHeight
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderItemDto item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    if (item.customizations != null && item.customizations!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: item.customizations!.entries.map((entry) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              '${entry.key}: ${entry.value}',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    if (item.notes != null && item.notes!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.note_alt_outlined, size: 14, color: AppColors.warning),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                item.notes!,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.warning,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'R\$ ${(item.unitPrice * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
              ),
            ],
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