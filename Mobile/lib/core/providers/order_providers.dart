import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza/data/repositories/order_repository.dart';
import 'package:pizza/data/models/order_models.dart';
import 'cart_providers.dart';

final _getIt = GetIt.instance;

/// Provider do OrderRepository
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return _getIt<OrderRepository>();
});

/// Provider da lista de pedidos
final ordersProvider = FutureProvider<OrdersResponse>((ref) async {
  final repository = ref.watch(orderRepositoryProvider);
  return await repository.getOrders();
});

/// Provider de pedido específico
final orderProvider = FutureProvider.family<OrderDto, String>((ref, id) async {
  final repository = ref.watch(orderRepositoryProvider);
  return await repository.getOrder(id);
});

/// Notifier para operações de pedidos
final orderNotifierProvider = StateNotifierProvider<OrderNotifier, AsyncValue<void>>((ref) {
  return OrderNotifier(ref.watch(orderRepositoryProvider), ref);
});

class OrderNotifier extends StateNotifier<AsyncValue<void>> {
  final OrderRepository _orderRepository;
  final Ref _ref;

  OrderNotifier(this._orderRepository, this._ref) : super(const AsyncValue.data(null));

  Future<OrderDto> createOrder(CreateOrderRequest request) async {
    state = const AsyncValue.loading();
    try {
      final order = await _orderRepository.createOrder(request);
      _ref.invalidate(ordersProvider);
      _ref.invalidate(cartProvider); // Limpa carrinho após pedido
      state = const AsyncValue.data(null);
      return order;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> cancelOrder(String id) async {
    state = const AsyncValue.loading();
    try {
      await _orderRepository.cancelOrder(id);
      _ref.invalidate(ordersProvider);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> reorder(String id) async {
    state = const AsyncValue.loading();
    try {
      await _orderRepository.reorder(id);
      _ref.invalidate(cartProvider);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}