import 'package:flutter_test/flutter_test.dart';
import 'package:platzi_api_architecture/routing/app_routes.dart';

void main() {
  test('application routes are stable', () {
    expect(AppRoutes.login, '/login');
    expect(AppRoutes.home, '/home');
  });
}
