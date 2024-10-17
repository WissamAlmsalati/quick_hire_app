import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: 'user_id', value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: 'user_id');
  }
}