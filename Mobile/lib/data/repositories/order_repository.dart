import 'package:pizza/data/models/order_models.dart';
import 'package:pizza/data/sources/api/api_service.dart';

/// Repositório de pedidos
class OrderRepository {
  final ApiService _apiService;

  OrderRepository(this._apiService);

  Future<OrdersResponse> getOrders() async {
    return await _apiService.getOrders();
  }

  Future<OrderDto> getOrder(String id) async {
    return await _apiService.getOrder(id);
  }

  Future<OrderDto> createOrder(CreateOrderRequest request) async {
    return await _apiService.createOrder(request);
  }

  Future<void> cancelOrder(String id) async {
    return await _apiService.cancelOrder(id);
  }

  Future<void> reorder(String id) async {
    return await _apiService.reorder(id);
  }
}