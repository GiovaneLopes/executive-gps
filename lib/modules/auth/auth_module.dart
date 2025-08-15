import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/auth/auth_routes.dart';
import 'package:executive_gps/modules/auth/blocs/auth_bloc.dart';
import 'package:executive_gps/modules/auth/pages/signin_page.dart';
import 'package:executive_gps/modules/auth/pages/splash_page.dart';
import 'package:executive_gps/modules/auth/pages/recover_password_page.dart';
import 'package:executive_gps/libs/modules/user/repositories/user_repository.dart';
import 'package:executive_gps/libs/modules/user/datasources/user_remote_datasource.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton<UserRemoteDatasource>(UserRemoteDatasourceImpl.new);
    i.addSingleton<UserRepository>(UserRepositoryImpl.new);
    i.addSingleton<AuthBloc>(AuthBloc.new);
  }

  @override
  void routes(r) {
    r.child(AuthRoutes.splash.name, child: (context) => const SplashPage());
    r.child(AuthRoutes.signIn.name, child: (context) => const SignInPage());
    r.child(AuthRoutes.recoverPassword.name,
        child: (context) => const RecoverPasswordPage());
  }
}
