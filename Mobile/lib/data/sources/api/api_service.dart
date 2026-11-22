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
    final data = response.data as Map<String, dynamic>;
    return CartResponse.fromJson(_transformCartResponse(data));
  }

  Future<CartItemDto> addCartItem(AddCartItemRequest request) async {
    final response = await _dio.post('/api/v1/cart/items', data: request.toJson());
    return CartItemDto.fromJson(_transformCartItem(response.data));
  }

  Future<CartItemDto> updateCartItem(String id, UpdateCartItemRequest request) async {
    final response = await _dio.put('/api/v1/cart/items/$id', data: request.toJson());
    return CartItemDto.fromJson(_transformCartItem(response.data));
  }

  /// Transforma a resposta da API para o formato esperado pelo modelo antigo
  Map<String, dynamic> _transformCartResponse(Map<String, dynamic> data) {
    if (data['items'] != null) {
      data['items'] = (data['items'] as List).map((item) => _transformCartItem(item)).toList();
    }
    // A API retorna deliveryFee e total, mas o modelo antigo só tem subtotal
    // Mantemos apenas os campos que o modelo espera
    return {
      'items': data['items'] ?? [],
      'subtotal': data['subtotal'] ?? 0.0,
    };
  }

  Map<String, dynamic> _transformCartItem(Map<String, dynamic> item) {
    // Helper to safely get numeric values
    double getDouble(dynamic value, double defaultValue) {
      if (value == null) return defaultValue;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    int getInt(dynamic value, int defaultValue) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    // Cria um ProductDto a partir dos campos planos da API
    // A API do carrinho não retorna informações de categoria, usamos valores padrão
    final product = {
      'id': item['productId'] ?? '',
      'name': item['productName'] ?? '',
      'description': item['productDescription'] ?? '',
      'imageUrl': item['productImageUrl'] ?? '',
      'price': getDouble(item['productPrice'], 0.0),
      'categoryId': 0,
      'categoryName': '',
      'categoryDisplayName': '',
      'prepTimeMinutes': getInt(item['prepTimeMinutes'], 0),
      'isAvailable': true,
      'customizationOptions': [],
    };

    // Converte selectedCustomizations para JSON string
    String? selectedCustomizationsJson;
    if (item['selectedCustomizations'] != null) {
      selectedCustomizationsJson = item['selectedCustomizations'].toString();
    }

    // userId - tenta obter do auth ou usa string vazia
    String userId = '';
    // createdAt - usa data atual
    final createdAt = DateTime.now().toIso8601String();

    return {
      'id': item['id'] ?? '',
      'userId': userId,
      'productId': item['productId'] ?? '',
      'quantity': getInt(item['quantity'], 1),
      'selectedCustomizationsJson': selectedCustomizationsJson ?? '',
      'notes': item['notes'] ?? '',
      'createdAt': createdAt,
      'product': product,
    };
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
    // Desktop API uses /api/v1/cart/checkout for creating orders
    final response = await _dio.post('/api/v1/cart/checkout', data: request.toJson());
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