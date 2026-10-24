import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Serviço de autenticação
class AuthService {
  static const _storage = FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';
  static const _userEmailKey = 'user_email';
  static const _userNameKey = 'user_name';
  static const _isLoggedInKey = 'is_logged_in';

  /// Verifica se o usuário está logado
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Obtém o token de autenticação
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Salva dados de login
  static Future<void> saveLoginData({
    required String token,
    required String userId,
    required String email,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await _storage.write(key: _tokenKey, value: token);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userEmailKey, email);
    await prefs.setString(_userNameKey, name);
    await prefs.setBool(_isLoggedInKey, true);
  }

  /// Obtém ID do usuário
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  /// Obtém email do usuário
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  /// Obtém nome do usuário
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  /// Realiza logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await _storage.delete(key: _tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userNameKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  /// Login mock (para desenvolvimento)
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    // Simula chamada de API
    await Future.delayed(const Duration(seconds: 1));

    // Mock: qualquer email/senha válida funciona
    if (email.contains('@') && password.length >= 6) {
      await saveLoginData(
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'user_123',
        email: email,
        name: email.split('@')[0],
      );
      return true;
    }
    return false;
  }

  /// Registro mock (para desenvolvimento)
  static Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    // Simula chamada de API
    await Future.delayed(const Duration(seconds: 1));

    // Mock: qualquer registro válido funciona
    if (email.contains('@') && password.length >= 6 && name.trim().split(' ').length >= 2) {
      await saveLoginData(
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
      );
      return true;
    }
    return false;
  }
}