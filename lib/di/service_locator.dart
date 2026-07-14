import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:platzi_api_architecture/config/app_constants.dart';
import 'package:platzi_api_architecture/data/repositories/auth_repository.dart';
import 'package:platzi_api_architecture/data/services/interceptors/auth_interceptor.dart';
import 'package:platzi_api_architecture/data/services/token_manager.dart';
import 'package:platzi_api_architecture/ui/auth/cubit/login_cubit.dart';
import 'package:platzi_api_architecture/ui/auth/cubit/register_cubit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/services/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(
    () => TokenManager(getIt<FlutterSecureStorage>()),
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  );

  dio.interceptors.add(AuthInterceptor(dio: dio, tokenManager: getIt()));

  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      apiClient: getIt<ApiClient>(),
      tokenManager: getIt<TokenManager>(),
    ),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(authRepository: getIt()));
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(authRepository: getIt()),
  );
}
