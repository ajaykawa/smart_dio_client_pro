import 'package:dio/dio.dart';
import '../auth/token_manager.dart';

class RefreshService {
  final Dio _dio = Dio();

  Future<bool> refreshToken() async {
    try {
      final response = await _dio.post(
        "https://api.example.com/refresh",
        data: {
          "refresh_token": TokenManager.refreshToken,
        },
      );

      TokenManager.saveTokens(
        accessToken: response.data["access_token"],
        refreshToken: response.data["refresh_token"],
      );

      return true;
    } catch (_) {
      return false;
    }
  }
}