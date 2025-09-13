import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final localization = FlutterLocalization.instance;
  @override
  void initState() {
    _configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: Modular.routerConfig,
          supportedLocales: localization.supportedLocales,
          localizationsDelegates: localization.localizationsDelegates,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
          )),
        );
      },
    );
  }

  void _configureLocalization() {
    localization.init(
      mapLocales: [
        const MapLocale('pt', {'title': 'Executive GPS'}),
      ],
      initLanguageCode: 'pt',
    );
    localization.onTranslatedLanguage = (locale) => setState(() {});
  }
}
