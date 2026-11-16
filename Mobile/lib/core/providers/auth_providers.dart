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

/// State do usuário atual
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, UserDto?>((ref) {
  return CurrentUserNotifier(ref.watch(authRepositoryProvider));
});

/// Notifier para gerenciar estado do usuário atual
class CurrentUserNotifier extends StateNotifier<UserDto?> {
  final AuthRepository _authRepository;

  CurrentUserNotifier(this._authRepository) : super(null);

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

/// Provider de autenticação (login/logout)
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  return AuthNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(currentUserProvider.notifier),
  );
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;
  final CurrentUserNotifier _currentUserNotifier;

  AuthNotifier(this._authRepository, this._currentUserNotifier) : super(const AsyncValue.data(null));

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
      );

      _currentUserNotifier.setUser(response.user);
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
      );

      _currentUserNotifier.setUser(response.user);
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
      _currentUserNotifier.clearUser();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}