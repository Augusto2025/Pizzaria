import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/core/constants/app_colors.dart';
import 'package:pizza/core/constants/app_strings.dart';
import 'package:pizza/core/constants/app_routes.dart';
import 'package:pizza/core/providers/cart_providers.dart';
import 'package:pizza/core/providers/address_providers.dart';
import 'package:pizza/core/providers/order_providers.dart';
import 'package:pizza/data/models/order_models.dart';
import 'package:pizza/shared/widgets/custom_button.dart';
import 'package:pizza/shared/widgets/custom_text_field.dart';
import 'package:pizza/data/models/address_models.dart';

/// Tela de Checkout - Finalizar Pedido
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  String? _selectedAddressId;
  int _selectedPaymentMethod = 0; // 0: dinheiro, 1: cartão, 2: pix, 3: saldo

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider);
    final addressesAsync = ref.watch(addressesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.checkout),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.cart);
            }
          },
        ),
      ),
      body: cartAsync.when(
        data: (cart) {
          final items = cart.items;
          final subtotal = cart.subtotal;
          const deliveryFee = 5.90;
          final total = subtotal + deliveryFee;

          if (items.isEmpty) {
            return _buildEmptyCart(context);
          }

          return addressesAsync.when(
            data: (addresses) {
              if (addresses.isEmpty && _selectedAddressId == null) {
                return _buildNoAddress(context);
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Endereço de Entrega
                      _buildAddressSection(addresses),
                      const SizedBox(height: 24),

                      // Forma de Pagamento
                      _buildPaymentSection(),
                      const SizedBox(height: 24),

                      // Observações
                      _buildNotesSection(),
                      const SizedBox(height: 24),

                      // Resumo do Pedido
                      _buildOrderSummary(subtotal, deliveryFee, total),
                      const SizedBox(height: 24),

                      // Botão Finalizar
                      CustomButton(
                        text: '${AppStrings.placeOrder} - R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                        icon: Icons.check_circle,
                        onPressed: () => _handlePlaceOrder(ref, context, total),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text('Erro ao carregar endereços'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => ref.invalidate(addressesProvider),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text('Erro ao carregar carrinho'),
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

  Widget _buildEmptyCart(BuildContext context) {
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

  Widget _buildNoAddress(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off_outlined, size: 80, color: AppColors.warning),
            const SizedBox(height: 16),
            Text(
              'Nenhum endereço cadastrado',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Adicione um endereço para prosseguir com o pedido',
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
      ),
    );
  }

  Widget _buildAddressSection(List<AddressDto> addresses) {
    // Seleciona endereço padrão se não houver selecionado
    if (_selectedAddressId == null) {
      final defaultAddress = addresses.where((a) => a.isDefault).firstOrNull;
      _selectedAddressId = defaultAddress?.id ?? addresses.first.id;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  AppStrings.deliveryAddressLabel,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (addresses.isNotEmpty) ...[
              DropdownButtonFormField<String>(
                initialValue: _selectedAddressId,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Endereço de entrega',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: addresses.map((address) {
                  final addressText = '${address.street}, ${address.number}'
                      '${address.complement.isNotEmpty ? ', ${address.complement}' : ''}'
                      ' - ${address.neighborhood}';
                  return DropdownMenuItem<String>(
                    value: address.id,
                    // Use the old model format: "Label [Padrão badge] - Address..."
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Label + Padrão badge
                          Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  address.label,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (address.isDefault) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: AppColors.warning,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'Padrão',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Address with ellipsis
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              addressText,
                              style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedAddressId = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecione um endereço';
                  }
                  return null;
                },
              ),
            ] else ...[
              Text(
                'Nenhum endereço disponível',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    final paymentMethods = [
      _PaymentOption(value: 0, label: 'Dinheiro', icon: Icons.payments_outlined, subtitle: 'Pague na entrega'),
      _PaymentOption(value: 1, label: 'Cartão', icon: Icons.credit_card_outlined, subtitle: 'Crédito/Débito'),
      _PaymentOption(value: 2, label: 'PIX', icon: Icons.qr_code_2_outlined, subtitle: 'QR Code ou copia e cola'),
      _PaymentOption(value: 3, label: 'Saldo do App', icon: Icons.account_balance_wallet_outlined, subtitle: 'Use seu saldo'),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.payment_outlined, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  AppStrings.paymentMethodLabel,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RadioGroup<int>(
              groupValue: _selectedPaymentMethod,
              onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
              child: Column(
                children: paymentMethods.map((method) => RadioListTile<int>(
                  value: method.value,
                  title: Row(
                    children: [
                      Icon(method.icon, color: AppColors.primary, size: 24),
                      const SizedBox(width: 12),
                      Text(method.label, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  subtitle: Text(method.subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.note_outlined, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Observações (opcional)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _notesController,
              label: 'Observações',
              hint: 'Ex: Interfone 101, portão azul, sem cebola...',
              maxLines: 3,
              prefixIcon: Icons.edit_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(double subtotal, double deliveryFee, double total) {
    return Card(
      color: AppColors.primary.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo do Pedido',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 16),
            _SummaryRow(label: AppStrings.subtotal, value: subtotal),
            _SummaryRow(label: AppStrings.deliveryFee, value: deliveryFee),
            const Divider(height: 24, color: AppColors.primary),
            _SummaryRow(
              label: AppStrings.total,
              value: total,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePlaceOrder(WidgetRef ref, BuildContext context, double total) async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAddressId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um endereço de entrega')),
      );
      return;
    }

    final request = CreateOrderRequest(
      deliveryAddressId: _selectedAddressId!,
      paymentMethod: _selectedPaymentMethod,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );

    // Invalidar providers imediatamente para resposta visual instantânea
    ref.invalidate(cartProvider);
    ref.invalidate(ordersProvider);

    if (!mounted) return;

    // Mostrar sucesso e navegar IMEDIATAMENTE (sem aguardar API)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.orderPlacedSuccess),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
    context.go(AppRoutes.orders);

    // Disparar salvamento na API em background (não bloqueia UI)
    // Se falhar, o usuário já navegou para pedidos; ordersProvider será atualizado ao recarregar
    _saveOrderInBackground(ref, request);
  }

  void _saveOrderInBackground(WidgetRef ref, CreateOrderRequest request) {
    // Fire-and-forget: não aguardamos, apenas disparamos
    Future.microtask(() async {
      try {
        final orderNotifier = ref.read(orderNotifierProvider.notifier);
        await orderNotifier.createOrder(request);
        // Atualizar lista de pedidos se ainda estiver na tela
        ref.invalidate(ordersProvider);
      } catch (e) {
        // Log do erro mas não bloqueia o usuário
        debugPrint('Erro ao salvar pedido na API: $e');
      }
    });
  }
}

class _PaymentOption {
  final int value;
  final String label;
  final IconData icon;
  final String subtitle;

  const _PaymentOption({
    required this.value,
    required this.label,
    required this.icon,
    required this.subtitle,
  });
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const _SummaryRow({
    super.key,
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