import 'package:dio/dio.dart';
import 'package:pizza/data/models/auth_models.dart';
import 'package:pizza/data/models/menu_models.dart';
import 'package:pizza/data/models/address_models.dart';
import 'package:pizza/data/models/order_models.dart';
import 'package:pizza/data/models/cart_models.dart';

/// API Service para comunicação com o backend desktop
class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  // Auth endpoints
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post('/api/v1/auth/login', data: request.toJson());
    return LoginResponse.fromJson(response.data);
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _dio.post('/api/v1/auth/register', data: request.toJson());
    return RegisterResponse.fromJson(response.data);
  }

  // Menu endpoints
  Future<MenuResponse> getMenu() async {
    final response = await _dio.get('/api/v1/menu');
    return MenuResponse.fromJson(response.data);
  }

  Future<ProductDto> getProduct(String id) async {
    final response = await _dio.get('/api/v1/menu/products/$id');
    return ProductDto.fromJson(response.data);
  }

  // Cart endpoints
  Future<CartResponse> getCart() async {
    final response = await _dio.get('/api/v1/cart');
    return CartResponse.fromJson(response.data);
  }

  Future<CartItemDto> addCartItem(AddCartItemRequest request) async {
    final response = await _dio.post('/api/v1/cart/items', data: request.toJson());
    return CartItemDto.fromJson(response.data);
  }

  Future<CartItemDto> updateCartItem(String id, UpdateCartItemRequest request) async {
    final response = await _dio.put('/api/v1/cart/items/$id', data: request.toJson());
    return CartItemDto.fromJson(response.data);
  }

  Future<void> removeCartItem(String id) async {
    await _dio.delete('/api/v1/cart/items/$id');
  }

  Future<void> clearCart() async {
    await _dio.delete('/api/v1/cart');
  }

  // Order endpoints
  Future<OrdersResponse> getOrders() async {
    final response = await _dio.get('/api/v1/orders');
    return OrdersResponse.fromJson(response.data);
  }

  Future<OrderDto> getOrder(String id) async {
    final response = await _dio.get('/api/v1/orders/$id');
    return OrderDto.fromJson(response.data);
  }

  Future<OrderDto> createOrder(CreateOrderRequest request) async {
    final response = await _dio.post('/api/v1/orders', data: request.toJson());
    return OrderDto.fromJson(response.data);
  }

  Future<void> cancelOrder(String id) async {
    await _dio.post('/api/v1/orders/$id/cancel');
  }

  Future<void> reorder(String id) async {
    await _dio.post('/api/v1/orders/$id/reorder');
  }

  // Profile endpoints
  Future<UserDto> getProfile() async {
    final response = await _dio.get('/api/v1/profile');
    return UserDto.fromJson(response.data);
  }

  Future<UserDto> updateProfile(UpdateProfileRequest request) async {
    final response = await _dio.put('/api/v1/profile', data: request.toJson());
    return UserDto.fromJson(response.data);
  }

  Future<void> deleteAccount() async {
    await _dio.delete('/api/v1/profile');
  }

  Future<UserStatsDto> getUserStats() async {
    final response = await _dio.get('/api/v1/profile/stats');
    return UserStatsDto.fromJson(response.data);
  }

  // Address endpoints
  Future<List<AddressDto>> getAddresses() async {
    final response = await _dio.get('/api/v1/addresses');
    final data = response.data;
    if (data is List) {
      return data.map((e) => AddressDto.fromJson(e)).toList();
    }
    final addressesResponse = AddressesResponse.fromJson(data);
    return addressesResponse.addresses;
  }

  Future<AddressDto> getAddress(String id) async {
    final response = await _dio.get('/api/v1/addresses/$id');
    return AddressDto.fromJson(response.data);
  }

  Future<AddressDto> createAddress(CreateAddressRequest request) async {
    final response = await _dio.post('/api/v1/addresses', data: request.toJson());
    return AddressDto.fromJson(response.data);
  }

  Future<AddressDto> updateAddress(String id, UpdateAddressRequest request) async {
    final response = await _dio.put('/api/v1/addresses/$id', data: request.toJson());
    return AddressDto.fromJson(response.data);
  }

  Future<void> deleteAddress(String id) async {
    await _dio.delete('/api/v1/addresses/$id');
  }

  Future<void> setDefaultAddress(String id) async {
    await _dio.post('/api/v1/addresses/$id/set-default');
  }
}