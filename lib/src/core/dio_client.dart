import 'package:dio/dio.dart';
import 'interceptors.dart';
import 'api_exception.dart';

class DioClient {
  late Dio dio;

  DioClient({required String baseUrl}) {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    dio.interceptors.add(AppInterceptors(dio));
  }

  Future request(
      String path, {
        String method = "GET",
        dynamic data,
        Map<String, dynamic>? query,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.request(
        path,
        data: data,
        queryParameters: query,
        options: Options(method: method, headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future multipartUpload(
      String path, {
        required Map<String, dynamic> data,
        required Map<String, String> filePaths,
        Function(int sent, int total)? onProgress,
      }) async {
    try {
      FormData formData = FormData();

      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      for (var entry in filePaths.entries) {
        formData.files.add(
          MapEntry(
            entry.key,
            await MultipartFile.fromFile(entry.value),
          ),
        );
      }

      final response = await dio.post(
        path,
        data: formData,
        onSendProgress: onProgress,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future get(String path, {Map<String, dynamic>? query}) =>
      request(path, query: query);

  Future post(String path, {dynamic data}) =>
      request(path, method: "POST", data: data);

  Future put(String path, {dynamic data}) =>
      request(path, method: "PUT", data: data);

  Future delete(String path, {dynamic data}) =>
      request(path, method: "DELETE", data: data);
}