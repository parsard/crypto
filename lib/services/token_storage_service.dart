// token_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyName = 'nobitex_api_token';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyName, value: token);
  }

  static Future<String?> readToken() async {
    return await _storage.read(key: _keyName);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyName);
  }
}
