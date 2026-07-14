import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  TokenManager(this._storage);

  final FlutterSecureStorage _storage;

  static const _accessToken = 'access_token';
  static const _refreshToken = 'refresh_token';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessToken, value: accessToken);

    await _storage.write(key: _refreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: _accessToken);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: _refreshToken);
  }

  Future<bool> hasSession() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return (accessToken?.isNotEmpty ?? false) ||
        (refreshToken?.isNotEmpty ?? false);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
