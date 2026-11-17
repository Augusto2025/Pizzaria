import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza/data/repositories/cart_repository.dart';
import 'package:pizza/data/models/cart_models.dart';

final _getIt = GetIt.instance;

/// Provider do CartRepository
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return _getIt<CartRepository>();
});

/// Provider do carrinho
final cartProvider = FutureProvider<CartResponse>((ref) async {
  final repository = ref.watch(cartRepositoryProvider);
  return await repository.getCart();
});

/// Notifier para operações do carrinho (Riverpod 3.x: AsyncNotifier)
class CartNotifier extends AsyncNotifier<void> {
  late final CartRepository _cartRepository;

  @override
  void build() {
    _cartRepository = ref.watch(cartRepositoryProvider);
  }

  Future<void> addItem(AddCartItemRequest request) async {
    state = const AsyncValue.loading();
    try {
      await _cartRepository.addCartItem(request);
      // Invalida o provider do carrinho para recarregar
      ref.invalidate(cartProvider);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateItem(String id, UpdateCartItemRequest request) async {
    state = const AsyncValue.loading();
    try {
      await _cartRepository.updateCartItem(id, request);
      ref.invalidate(cartProvider);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> removeItem(String id) async {
    state = const AsyncValue.loading();
    try {
      await _cartRepository.removeCartItem(id);
      ref.invalidate(cartProvider);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();
    try {
      await _cartRepository.clearCart();
      ref.invalidate(cartProvider);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// Provider do CartNotifier (Riverpod 3.x: AsyncNotifierProvider)
final cartNotifierProvider = AsyncNotifierProvider<CartNotifier, void>(
  CartNotifier.new,
);