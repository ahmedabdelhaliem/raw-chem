import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/common/resources/theme_manager.dart';

import '../common/resources/app_router.dart';
import 'imports.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((locale) {
      if (mounted) context.setLocale(locale);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.getTheme(),
          routerConfig: AppRouters.router,
        );
      },
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'navigatorKey ${DateTime.now().millisecondsSinceEpoch}',
);
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

// ===========================================================

// lib/ma
