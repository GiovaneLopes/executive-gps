import 'package:executive_gps/modules/shared/utils/app_route.dart';
// ignore_for_file: annotate_overrides, overridden_fields

class TaskRoutes extends AppRoute {
  final String name;
  final NavigatorType? type;
  TaskRoutes(this.name, {this.type}) : super(module: '/tasks');

  static final add = TaskRoutes('/add');
  static final details = TaskRoutes('/details');
  static final checklist = TaskRoutes('/checklist');
  static final imageDetails = TaskRoutes('/image-details');
  static final signature = TaskRoutes('/signature');
  static final photos = TaskRoutes('/photos');
  static final summary = TaskRoutes('/summary');
}
