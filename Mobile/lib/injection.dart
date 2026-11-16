import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizza/core/services/auth_service.dart';
import 'package:pizza/data/sources/api/api_service.dart';
import 'package:pizza/data/repositories/auth_repository.dart';
import 'package:pizza/data/repositories/menu_repository.dart';
import 'package:pizza/data/repositories/cart_repository.dart';
import 'package:pizza/data/repositories/order_repository.dart';
import 'package:pizza/data/repositories/address_repository.dart';

/// Injeção de dependência usando GetIt
final getIt = GetIt.instance;

/// Configura todas as dependências da aplicação
Future<void> configureDependencies() async {
  // External packages
  getIt.registerLazySingleton<Dio>(() => _createDio());
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // Services
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  // API Service
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<ApiService>()));
  getIt.registerLazySingleton<MenuRepository>(() => MenuRepository(getIt<ApiService>()));
  getIt.registerLazySingleton<CartRepository>(() => CartRepository(getIt<ApiService>()));
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepository(getIt<ApiService>()));
  getIt.registerLazySingleton<AddressRepository>(() => AddressRepository(getIt<ApiService>()));
}

/// Cria instância do Dio com configurações padrão
Dio _createDio() {
  // TODO: Configurar a URL base do API do desktop
  // Se o desktop estiver rodando localmente, use: http://10.0.2.2:5000 (Android emulator)
  // Para iOS simulator: http://localhost:5000
  // Para dispositivo físico: http://<IP_DO_COMPUTADOR>:5000
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:5000', // URL do API do desktop (ajustar conforme necessário)
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Interceptor para logging
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
    ),
  );

  // Interceptor para adicionar token de autenticação
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await AuthService.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        // Tratar erros globais (ex: 401 -> logout)
        if (error.response?.statusCode == 401) {
          // Token expirado ou inválido
          await AuthService.logout();
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
}

/// Inicializa as dependências (chamar no main.dart antes de runApp)
Future<void> initDependencies() async {
  await configureDependencies();
}