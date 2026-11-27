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

/// Configuração de retry para Dio
class RetryOptions {
  final int maxRetries;
  final Duration baseDelay;
  final Duration maxDelay;
  final List<DioExceptionType> retryableTypes;

  const RetryOptions({
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 2),
    this.maxDelay = const Duration(seconds: 30),
    this.retryableTypes = const [
      DioExceptionType.connectionTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.connectionError,
      DioExceptionType.badResponse, // 5xx errors
    ],
  });

  Duration delayForAttempt(int attempt) {
    final delay = baseDelay * (1 << attempt); // Exponential backoff: 2s, 4s, 8s...
    return delay > maxDelay ? maxDelay : delay;
  }

  bool shouldRetry(DioException error, int attempt) {
    if (attempt >= maxRetries) return false;
    if (!retryableTypes.contains(error.type)) return false;
    // For badResponse, only retry on 5xx server errors
    if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;
      return statusCode != null && statusCode >= 500;
    }
    return true;
  }
}

/// Interceptor que implementa retry com backoff exponencial
class RetryInterceptor extends Interceptor {
  final RetryOptions options;
  final Dio _dio;

  RetryInterceptor(this._dio, {this.options = const RetryOptions()});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Extrai o número de tentativas do request options (custom property)
    final attempts = (err.requestOptions.extra['_retry_attempts'] as int?) ?? 0;

    if (options.shouldRetry(err, attempts)) {
      final delay = options.delayForAttempt(attempts);
      print('🔄 [Retry] Tentativa ${attempts + 1}/${options.maxRetries} após ${delay.inSeconds}s - Erro: ${err.type}');

      // Aguarda o delay
      await Future.delayed(delay);

      // Incrementa contador e tenta novamente
      err.requestOptions.extra['_retry_attempts'] = attempts + 1;

      try {
        final response = await _dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        // Se falhar novamente, o onError será chamado de novo com attempts incrementado
        handler.next(err);
        return;
      }
    }

    // Não deve retry ou esgotou tentativas
    if (attempts > 0) {
      print('❌ [Retry] Esgotadas $attempts tentativas de retry');
    }
    handler.next(err);
  }
}

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
  // ============================================================
  // CONFIGURE AQUI A URL DA API (Render Cloud)
  // ============================================================
  // Render API:    'https://pizzaria-api-ffie.onrender.com'
  // Local (emulador): 'http://10.0.2.2:5000'
  // Local (iOS):        'http://localhost:5000'
  // ============================================================
  const String apiBaseUrl = 'https://pizzaria-api-ffie.onrender.com'; // API Render (Produção)

  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
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

  // Interceptor de retry com backoff exponencial (para timeouts da API Render)
  // Passa o próprio dio para que o retry use a mesma instância com todos os interceptors
  dio.interceptors.add(RetryInterceptor(dio,
    options: RetryOptions(
      maxRetries: 3,
      baseDelay: Duration(seconds: 3),
      maxDelay: Duration(seconds: 30),
    ),
  ));

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