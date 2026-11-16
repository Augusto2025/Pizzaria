import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza/data/repositories/menu_repository.dart';
import 'package:pizza/data/models/menu_models.dart';

final _getIt = GetIt.instance;

/// Provider do MenuRepository
final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return _getIt<MenuRepository>();
});

/// Provider do menu (categorias e produtos)
final menuProvider = FutureProvider<MenuResponse>((ref) async {
  final repository = ref.watch(menuRepositoryProvider);
  return await repository.getMenu();
});

/// Provider de produtos por categoria
final productsByCategoryProvider = Provider.family<List<ProductDto>, String>((ref, categoryName) {
  final menuAsync = ref.watch(menuProvider);
  return menuAsync.when(
    data: (menu) => menu.products.where((p) => p.categoryName.toLowerCase() == categoryName.toLowerCase()).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Provider de produto específico
final productProvider = FutureProvider.family<ProductDto, String>((ref, id) async {
  final repository = ref.watch(menuRepositoryProvider);
  return await repository.getProduct(id);
});