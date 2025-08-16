import 'package:_qurinom_chat_app/core/core/storage/secure_storage.dart';
import 'package:_qurinom_chat_app/data/app_client.dart';
import 'package:_qurinom_chat_app/data/resources/auth_remote.dart';
import 'package:_qurinom_chat_app/features/auth/model/auth_response.dart';

class AuthRepository {
  final SecureStore _store;
  final AuthRemote _remote;
  AuthRepository(this._store, {String? token})
    : _remote = AuthRemote(ApiClient(token: token));

  Future<AuthResponse> login(String email, String password, String role) async {
    final res = await _remote.login(
      email: email,
      password: password,
      role: role,
    );
    await _store.setToken(res.token);
    await _store.setUserId(res.user.id);
    return res;
  }

  Future<String?> token() => _store.getToken();
  Future<String?> userId() => _store.getUserId();
  Future<void> logout() => _store.clear();
}
