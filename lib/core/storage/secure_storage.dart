import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final _s = const FlutterSecureStorage();
  Future<void> setToken(String token) => _s.write(key: 'token', value: token);
  Future<String?> getToken() => _s.read(key: 'token');
  Future<void> setUserId(String id) => _s.write(key: 'userId', value: id);
  Future<String?> getUserId() => _s.read(key: 'userId');
  Future<void> clear() => _s.deleteAll();
}
