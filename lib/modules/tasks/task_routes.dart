import 'package:executive_gps/modules/shared/utils/app_route.dart';
// ignore_for_file: annotate_overrides, overridden_fields

class TaskRoutes extends AppRoute {
  final String name;
  final NavigatorType? type;
  TaskRoutes(this.name, {this.type}) : super(module: '/tasks');

  static final add = TaskRoutes('/add');
  static final employeeDetails = TaskRoutes('/employee-details');
  static final imageDetails = TaskRoutes('/image-details');
}
