import 'package:executive_gps/modules/shared/utils/app_route.dart';
// ignore_for_file: annotate_overrides, overridden_fields

class AuthRoutes extends AppRoute {
  final String name;
  final NavigatorType? type;
  AuthRoutes(this.name, {this.type}) : super(module: '/auth');

  static final splash = AuthRoutes('/');
  static final signIn =
      AuthRoutes('/sign-in', type: NavigatorType.pushReplacement);
  static final recoverPassword = AuthRoutes('/recover-password');
}
