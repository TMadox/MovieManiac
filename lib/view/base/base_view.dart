import 'package:flutter/material.dart';
import 'package:movies_app/core/Resources/routes_manager.dart';
import 'package:movies_app/core/Resources/theme_manager.dart';
import 'package:movies_app/core/util/injection.dart';
import 'package:movies_app/core/util/navigator.dart';
import 'package:overlay_support/overlay_support.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  factory MyApp() => instance;
  MyApp._internal();
  int appState = 0;
  static final MyApp instance = MyApp._internal();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        navigatorKey: locator.get<NavigatorService>().navigatorKey,
        theme: ThemeManger.lightTheme,
      ),
    );
  }
}
