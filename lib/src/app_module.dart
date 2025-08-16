import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/home/home_routes.dart';
import 'package:executive_gps/modules/home/home_module.dart';
import 'package:executive_gps/modules/auth/auth_routes.dart';
import 'package:executive_gps/modules/auth/auth_module.dart';
import 'package:executive_gps/modules/auth/pages/splash_page.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        AuthModule(),
        HomeModule(),
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
  }
}
