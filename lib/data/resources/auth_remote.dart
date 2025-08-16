import 'package:_qurinom_chat_app/data/app_client.dart';
import 'package:_qurinom_chat_app/features/auth/model/auth_response.dart';

class AuthRemote {
  final ApiClient _client;
  AuthRemote(this._client);

  Future<AuthResponse> login({
    required String email,
    required String password,
    required String role,
  }) async {
    final res = await _client.dio.post(
      '/user/login',
      data: {'email': email, 'password': password, 'role': role},
    );
    return AuthResponse.fromJson(res.data['data'] as Map<String, dynamic>);
  }
}
