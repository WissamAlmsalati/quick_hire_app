import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenChecker {
  final FlutterSecureStorage secureStorage;

  TokenChecker(this.secureStorage);

  Future<bool> hasToken() async {
    final token = await secureStorage.read(key: 'token');
    return token != null;
  }
}