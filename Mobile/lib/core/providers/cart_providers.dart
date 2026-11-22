import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza/data/repositories/cart_repository.dart';
import 'package:pizza/data/models/cart_models.dart';

final _getIt = GetIt.instance;

/// Provider do CartRepository
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return _getIt<CartRepository>();
});

/// Notifier para gerenciar o estado do carrinho (Riverpod 3.x: AsyncNotifier)
/// Este substitui o FutureProvider para ter controle total sobre o estado
class CartNotifier extends AsyncNotifier<CartResponse> {
  CartRepository get _cartRepository => ref.read(cartRepositoryProvider);

  @override
  Future<CartResponse> build() async {
    return await _cartRepository.getCart();
  }

  Future<void> addItem(AddCartItemRequest request) async {
    state = const AsyncValue.loading();
    try {
      await _cartRepository.addCartItem(request);
      // Recarrega o carrinho após adicionar
      final cart = await _cartRepository.getCart();
      state = AsyncValue.data(cart);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateItem(String id, UpdateCartItemRequest request) async {
    state = const AsyncValue.loading();
    try {
      await _cartRepository.updateCartItem(id, request);
      final cart = await _cartRepository.getCart();
      state = AsyncValue.data(cart);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> removeItem(String id) async {
    state = const AsyncValue.loading();
    try {
      await _cartRepository.removeCartItem(id);
      final cart = await _cartRepository.getCart();
      state = AsyncValue.data(cart);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();
    try {
      await _cartRepository.clearCart();
      final cart = await _cartRepository.getCart();
      state = AsyncValue.data(cart);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// Provider do CartNotifier (Riverpod 3.x: AsyncNotifierProvider)
/// Agora retorna CartResponse diretamente, não void
final cartProvider = AsyncNotifierProvider<CartNotifier, CartResponse>(
  CartNotifier.new,
);

/// Provider para obter o total de itens no carrinho (para badge)
final cartItemCountProvider = Provider<int>((ref) {
  final cartAsync = ref.watch(cartProvider);
  return cartAsync.when(
    data: (cart) => cart.items.fold(0, (sum, item) => sum + item.quantity),
    loading: () => 0,
    error: (_, __) => 0,
  );
});