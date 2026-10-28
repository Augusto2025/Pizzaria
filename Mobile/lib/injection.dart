import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizza/core/services/auth_service.dart';

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

  // Repositories (to be implemented)
  // getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  // getIt.registerLazySingleton<MenuRepository>(() => MenuRepositoryImpl());
  // getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());
  // getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  // Use Cases (to be implemented)
  // getIt.registerFactory(() => LoginUseCase(getIt<AuthRepository>()));
  // getIt.registerFactory(() => RegisterUseCase(getIt<AuthRepository>()));
  // getIt.registerFactory(() => GetMenuUseCase(getIt<MenuRepository>()));
  // getIt.registerFactory(() => CreateOrderUseCase(getIt<OrderRepository>()));
  // getIt.registerFactory(() => GetOrdersUseCase(getIt<OrderRepository>()));
}

/// Cria instância do Dio com configurações padrão
Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.pizzaria.example.com/v1', // TODO: Configurar URL real
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
      onError: (error, handler) {
        // TODO: Tratar erros globais (ex: 401 -> logout)
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