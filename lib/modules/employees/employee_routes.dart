import 'package:executive_gps/modules/shared/utils/app_route.dart';
// ignore_for_file: annotate_overrides, overridden_fields

class EmployeeRoutes extends AppRoute {
  final String name;
  final NavigatorType? type;
  EmployeeRoutes(this.name, {this.type}) : super(module: '/employees');

  static final add = EmployeeRoutes('/add');
}
