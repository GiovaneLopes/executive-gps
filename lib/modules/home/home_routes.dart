import 'package:executive_gps/modules/shared/utils/app_route.dart';
// ignore_for_file: annotate_overrides, overridden_fields

class HomeRoutes extends AppRoute {
  final String name;
  final NavigatorType? type;

  HomeRoutes(this.name, {this.type}) : super(module: '/home');

  static final home = HomeRoutes('/',type: NavigatorType.pushReplacement);
}
