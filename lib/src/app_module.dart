import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/home/home_routes.dart';
import 'package:executive_gps/modules/home/home_module.dart';
import 'package:executive_gps/modules/auth/auth_routes.dart';
import 'package:executive_gps/modules/auth/auth_module.dart';
import 'package:executive_gps/modules/tasks/task_module.dart';
import 'package:executive_gps/modules/tasks/task_routes.dart';
import 'package:executive_gps/modules/auth/pages/splash_page.dart';
import 'package:executive_gps/modules/customers/customer_routes.dart';
import 'package:executive_gps/modules/customers/customer_module.dart';
import 'package:executive_gps/modules/employees/employee_routes.dart';
import 'package:executive_gps/modules/employees/employee_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        AuthModule(),
        HomeModule(),
        EmployeeModule(),
        CustomerModule(),
        TaskModule(),
      ];

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const SplashPage(),
    );
    r.module(
      AuthRoutes.splash.module,
      module: AuthModule(),
    );
    r.module(
      HomeRoutes.home.module,
      module: HomeModule(),
    );
    r.module(
      EmployeeRoutes.add.module,
      module: EmployeeModule(),
    );
    r.module(
      CustomerRoutes.add.module,
      module: CustomerModule(),
    );
    r.module(
      TaskRoutes.add.module,
      module: TaskModule(),
    );
  }
}
