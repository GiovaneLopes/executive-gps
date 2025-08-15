import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum NavigatorType {
  pushNamed,
  pushReplacement,
}

class AppRoute extends Route {
  final String module;
  final String? name;
  final NavigatorType? type;
  AppRoute({
    this.module = '',
    this.name,
    this.type = NavigatorType.pushNamed,
  });

  String get path => module + name!;

  void navigate() {
    if (type == NavigatorType.pushReplacement) {
      Modular.to.navigate(path);
    } else {
      Modular.to.pushNamed(path);
    }
  }
}
