import 'package:pizza/data/models/menu_models.dart';
import 'package:pizza/data/sources/api/api_service.dart';

/// Repositório do cardápio/menu
class MenuRepository {
  final ApiService _apiService;

  MenuRepository(this._apiService);

  Future<MenuResponse> getMenu() async {
    return await _apiService.getMenu();
  }

  Future<ProductDto> getProduct(String id) async {
    return await _apiService.getProduct(id);
  }
}