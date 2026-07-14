import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:platzi_api_architecture/data/models/register_body.dart';
import 'package:platzi_api_architecture/data/services/token_manager.dart';
import 'package:platzi_api_architecture/ui/core/network/api_result.dart';

import '../models/auth_tokens.dart';
import '../services/api_client.dart';
import '../services/endpoints/auth_endpoints.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final TokenManager _tokenManager;

  const AuthRepository({
    required ApiClient apiClient,
    required TokenManager tokenManager,
  }) : _apiClient = apiClient,
       _tokenManager = tokenManager;

  Future<ApiResult<AuthTokens>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        AuthEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final tokens = AuthTokens.fromJson(response.data);

      await _tokenManager.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );

      return Success(tokens);
    } on DioException catch (e) {
      return Failure(
        message: e.response?.data['message'] ?? 'Login failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<ApiResult<void>> register({required RegisterBody registerBody}) async {
    try {
      await _apiClient.post(
        AuthEndpoints.register,
        data: registerBody.toJson(),
      );
      return const Success(null);
    } on DioException catch (e) {
      return Failure(
        message: e.response?.data['message'] ?? 'Account creation failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<ApiResult<String>> uploadAvatar({
    required Uint8List bytes,
    required String fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes, filename: fileName),
      });
      final response = await _apiClient.post(
        AuthEndpoints.uploadFile,
        data: formData,
      );
      final imageUrl = response.data['location'] as String?;
      if (imageUrl == null || imageUrl.isEmpty) {
        return const Failure(message: 'Image upload did not return a URL');
      }
      return Success(imageUrl);
    } on DioException catch (e) {
      return Failure(
        message: e.response?.data['message'] ?? 'Image upload failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
