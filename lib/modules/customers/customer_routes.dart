import 'package:executive_gps/modules/shared/utils/app_route.dart';
// ignore_for_file: annotate_overrides, overridden_fields

class CustomerRoutes extends AppRoute {
  final String name;
  final NavigatorType? type;
  CustomerRoutes(this.name, {this.type}) : super(module: '/customers');

  static final add = CustomerRoutes('/add');
  static final imageDetails = CustomerRoutes('/image-details');
}
