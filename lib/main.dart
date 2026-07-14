import 'package:flutter/widgets.dart';
import 'package:platzi_api_architecture/app.dart';
import 'package:platzi_api_architecture/di/service_locator.dart';
import 'package:platzi_api_architecture/routing/app_routes.dart';
import 'package:platzi_api_architecture/data/services/token_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  final hasSession = await getIt<TokenManager>().hasSession();
  runApp(
    ShopApp(initialRoute: hasSession ? AppRoutes.home : AppRoutes.login),
  );
}
