import 'dart:async';

import 'package:dio/dio.dart';
import 'package:platzi_api_architecture/data/services/token_manager.dart';

import '../endpoints/auth_endpoints.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required Dio dio, required TokenManager tokenManager})
    : _dio = dio,
      _tokenManager = tokenManager,
      _refreshDio = Dio(
        BaseOptions(
          baseUrl: dio.options.baseUrl,
          connectTimeout: dio.options.connectTimeout,
          receiveTimeout: dio.options.receiveTimeout,
          sendTimeout: dio.options.sendTimeout,
          headers: Map<String, dynamic>.from(dio.options.headers),
        ),
      );

  final Dio _dio;

  final Dio _refreshDio;

  final TokenManager _tokenManager;

  Completer<void>? _refreshCompleter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenManager.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final path = err.requestOptions.path;
    final isAuthenticationRequest =
        path == AuthEndpoints.login || path == AuthEndpoints.refreshToken;

    if (err.response?.statusCode != 401 || isAuthenticationRequest) {
      handler.next(err);
      return;
    }

    if (_refreshCompleter != null) {
      try {
        await _refreshCompleter!.future;

        final request = err.requestOptions;

        final token = await _tokenManager.getAccessToken();

        request.headers['Authorization'] = 'Bearer $token';

        final response = await _dio.fetch(request);

        handler.resolve(response);
      } catch (_) {
        handler.next(err);
      }

      return;
    }

    _refreshCompleter = Completer<void>();

    try {
      final refreshToken = await _tokenManager.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        await _logout();
        _refreshCompleter?.complete();
        handler.next(err);
        return;
      }

      final response = await _refreshDio.post(
        AuthEndpoints.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      final newAccessToken = response.data['access_token'];

      final newRefreshToken = response.data['refresh_token'];

      await _tokenManager.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      _refreshCompleter?.complete();

      final request = err.requestOptions;

      if (request.extra['retried'] == true) {
        handler.next(err);
        return;
      }

      request.extra['retried'] = true;

      request.headers['Authorization'] = 'Bearer $newAccessToken';

      final cloneResponse = await _dio.fetch(request);

      handler.resolve(cloneResponse);
    } on DioException {
      if (!(_refreshCompleter?.isCompleted ?? true)) {
        _refreshCompleter?.complete();
      }

      await _logout();

      handler.next(err);
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> _logout() async {
    await _tokenManager.clear();
  }
}
