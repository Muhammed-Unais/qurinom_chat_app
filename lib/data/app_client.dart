import 'package:_qurinom_chat_app/core/app_config.dart';
import 'package:_qurinom_chat_app/data/auth_interceptor.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;
  ApiClient._(this.dio);

  factory ApiClient({String? token}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 12),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(AuthInterceptor(() => token));
    return ApiClient._(dio);
  }
}
