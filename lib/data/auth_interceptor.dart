import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String? Function() tokenProvider;
  AuthInterceptor(this.tokenProvider);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = tokenProvider();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout) {
      err = DioException.connectionTimeout(
        timeout: const Duration(seconds: 8),
        requestOptions: err.requestOptions,
      );
    }
    super.onError(err, handler);
  }
}
