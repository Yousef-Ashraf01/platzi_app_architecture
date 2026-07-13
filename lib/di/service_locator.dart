import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/services/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
}
