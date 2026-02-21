import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _storage = FlutterSecureStorage();

  static String? _accessToken;
  static String? _refreshToken;

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    await _storage.write(key: "accessToken", value: accessToken);
    await _storage.write(key: "refreshToken", value: refreshToken);
  }

  static Future<void> loadTokens() async {
    _accessToken = await _storage.read(key: "accessToken");
    _refreshToken = await _storage.read(key: "refreshToken");
  }

  static String? get accessToken => _accessToken;
  static String? get refreshToken => _refreshToken;

  static Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
    await _storage.deleteAll();
  }
}