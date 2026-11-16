import 'package:pizza/data/models/cart_models.dart';
import 'package:pizza/data/sources/api/api_service.dart';

/// Repositório do carrinho
class CartRepository {
  final ApiService _apiService;

  CartRepository(this._apiService);

  Future<CartResponse> getCart() async {
    return await _apiService.getCart();
  }

  Future<CartItemDto> addCartItem(AddCartItemRequest request) async {
    return await _apiService.addCartItem(request);
  }

  Future<CartItemDto> updateCartItem(String id, UpdateCartItemRequest request) async {
    return await _apiService.updateCartItem(id, request);
  }

  Future<void> removeCartItem(String id) async {
    return await _apiService.removeCartItem(id);
  }

  Future<void> clearCart() async {
    return await _apiService.clearCart();
  }
}