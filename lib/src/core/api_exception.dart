import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException(this.message, {this.code});

  factory ApiException.fromDio(DioException e) {
    return ApiException(
      e.response?.data["message"] ?? e.message ?? "Unknown error",
      code: e.response?.statusCode,
    );
  }
}