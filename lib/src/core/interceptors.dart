import 'package:dio/dio.dart';
import '../auth/token_manager.dart';
import '../auth/refresh_service.dart';
import '../ui/global_loader.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;
  AppInterceptors(this.dio);

  @override
  void onRequest(options, handler) {
    GlobalLoader.show();

    if (TokenManager.accessToken != null) {
      options.headers["Authorization"] =
      "Bearer ${TokenManager.accessToken}";
    }

    return handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    GlobalLoader.hide();
    return handler.next(response);
  }

  @override
  void onError(DioException err, handler) async {
    GlobalLoader.hide();

    if (err.response?.statusCode == 401) {
      bool refreshed = await RefreshService().refreshToken();

      if (refreshed) {
        final retryResponse = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: {
              "Authorization": "Bearer ${TokenManager.accessToken}"
            },
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(retryResponse);
      }
    }

    return handler.next(err);
  }
}