import 'package:flutter_modular/flutter_modular.dart';
import 'package:executive_gps/modules/home/blocs/home_bloc.dart';
import 'package:executive_gps/modules/home/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton<HomeBloc>(HomeBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
