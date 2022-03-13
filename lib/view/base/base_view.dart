import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/Resources/routes_manager.dart';
import 'package:movies_app/core/Resources/theme_manager.dart';
import 'package:movies_app/core/util/deep_linking.dart';
import 'package:movies_app/core/util/injection.dart';
import 'package:movies_app/core/util/notifications.dart';
import 'package:movies_app/view/details/details_view.dart';
import 'package:movies_app/view/movies/movies_view.dart';
import 'package:movies_app/view/splash/splash_view.dart';

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
  DeepLinking deepLinking = locator.get<DeepLinking>();
  String? movieId;
  @override
  void initState() {
    locator.get<NotificationManager>().onForegroundNotification();
    locator.get<NotificationManager>().onBackgroundNotification();
    deepLinking.state.listen(
      (event) async {
        if (kDebugMode) {
          log(event.toString());
        }
        Map parameters = Uri.parse(event["link"]).queryParameters;
        String route = Uri.parse(event["link"]).path;
        if (event["first"]) {
          Get.offNamed(
            AppRoutes.splashRoute,
            parameters: {"next_route": route, "movie_id": parameters["id"]},
            preventDuplicates: false,
          );
        } else {
          if (Get.currentRoute == route) {
            Get.offNamed(route,
                arguments: parameters["id"], preventDuplicates: false);
          } else {
            Get.toNamed(route, arguments: parameters["id"]);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: RouteGenerator.getRoute,
      // initialRoute: Routes.splashRoute,
      theme: ThemeManger.lightTheme,
      getPages: [
        GetPage(name: AppRoutes.moviesRoute, page: () => const MoviesView()),
        GetPage(name: AppRoutes.detailsRoute, page: () => const DetailsView()),
        GetPage(
          name: AppRoutes.splashRoute,
          page: () => const SplashView(),
        )
      ],
    );
  }
}
