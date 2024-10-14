import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSource(this.storage);

  Future<void> cacheToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }

  Future<void> cacheId(String token) async {
    await storage.write(key: 'id', value: token);
  }

  Future<String?> getId() async {
    return await storage.read(key: 'id');
  }

  Future<void> deleteId() async {
    await storage.delete(key: 'id');
  }
}