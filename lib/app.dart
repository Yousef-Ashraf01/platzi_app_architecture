import 'package:flutter/material.dart';
import 'package:platzi_api_architecture/config/app_constants.dart';
import 'package:platzi_api_architecture/routing/app_router.dart';
import 'package:platzi_api_architecture/ui/core/themes/app_theme.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
