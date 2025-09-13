import 'flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:executive_gps/src/app_module.dart';
import 'package:executive_gps/src/app_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:executive_gps/firebase_options_dev.dart' as dev;
import 'package:executive_gps/firebase_options_prod.dart' as prod;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  final flavor = switch (F.appFlavor) {
    Flavor.dev => dev.DefaultFirebaseOptions.currentPlatform,
    Flavor.prod => prod.DefaultFirebaseOptions.currentPlatform,
  };
  await Firebase.initializeApp(options: flavor);
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
