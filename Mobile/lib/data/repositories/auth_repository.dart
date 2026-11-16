import 'package:pizza/data/models/auth_models.dart';
import 'package:pizza/data/sources/api/api_service.dart';

/// Repositório de autenticação
class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<LoginResponse> login(LoginRequest request) async {
    return await _apiService.login(request);
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    return await _apiService.register(request);
  }

  Future<UserDto> getProfile() async {
    return await _apiService.getProfile();
  }

  Future<UserDto> updateProfile(UpdateProfileRequest request) async {
    return await _apiService.updateProfile(request);
  }

  Future<void> deleteAccount() async {
    return await _apiService.deleteAccount();
  }

  Future<UserStatsDto> getUserStats() async {
    return await _apiService.getUserStats();
  }
}