import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza/core/services/auth_service.dart';
import 'package:pizza/data/repositories/auth_repository.dart';
import 'package:pizza/data/models/auth_models.dart';
import 'package:pizza/data/sources/api/api_service.dart';

final _getIt = GetIt.instance;

/// Provider do AuthService (existente)
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Provider do ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return _getIt<ApiService>();
});

/// Provider do AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return _getIt<AuthRepository>();
});

/// Notifier para gerenciar estado do usuário atual (Riverpod 3.x: Notifier)
class CurrentUserNotifier extends Notifier<UserDto?> {
  late final AuthRepository _authRepository;

  @override
  UserDto? build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return null;
  }

  Future<void> loadUser() async {
    try {
      final user = await _authRepository.getProfile();
      state = user;
    } catch (e) {
      state = null;
    }
  }

  void setUser(UserDto user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    final updatedUser = await _authRepository.updateProfile(request);
    state = updatedUser;
  }
}

/// Provider do CurrentUserNotifier (Riverpod 3.x: NotifierProvider)
final currentUserProvider = NotifierProvider<CurrentUserNotifier, UserDto?>(
  CurrentUserNotifier.new,
);

/// Notifier para autenticação (login/logout) - Riverpod 3.x: AsyncNotifier
class AuthNotifier extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  void build() {
    _authRepository = ref.watch(authRepositoryProvider);
  }

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _authRepository.login(request);

      await AuthService.saveLoginData(
        token: response.token,
        userId: response.user.id,
        email: response.user.email,
        name: response.user.name,
        password: password, // Salva para "Último acesso"
      );

      ref.read(currentUserProvider.notifier).setUser(response.user);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    state = const AsyncValue.loading();
    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
      );
      final response = await _authRepository.register(request);

      await AuthService.saveLoginData(
        token: response.token,
        userId: response.user.id,
        email: response.user.email,
        name: response.user.name,
        password: password, // Salva para "Último acesso"
      );

      ref.read(currentUserProvider.notifier).setUser(response.user);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await AuthService.logout();
      ref.read(currentUserProvider.notifier).clearUser();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// Provider do AuthNotifier (Riverpod 3.x: AsyncNotifierProvider)
final authProvider = AsyncNotifierProvider<AuthNotifier, void>(
  AuthNotifier.new,
);