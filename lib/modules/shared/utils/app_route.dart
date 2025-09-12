import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum NavigatorType {
  pushNamed,
  pushReplacement,
}

class AppRoute extends Route {
  final String module;
  final String? name;
  final ModularArguments? args;
  final NavigatorType? type;
  AppRoute({
    this.module = '',
    this.name,
    this.args,
    this.type = NavigatorType.pushNamed,
  });

  String get path => module + name!;

  Map<String, dynamic>? get queryParams => args?.queryParams;

  void navigate() {
    if (type == NavigatorType.pushReplacement) {
      Modular.to.navigate(path);
    } else {
      Modular.to.pushNamed(path);
    }
  }
}
