import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/util/deep_linking.dart';
import 'package:movies_app/core/util/injection.dart';
import 'package:movies_app/core/util/navigator.dart';
import 'package:movies_app/core/util/notifications.dart';
import 'package:movies_app/view/movies/movies_view.dart';
import 'package:movies_app/view/movies/movies_viewmodel.dart';

class SplashView extends ConsumerWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DeepLinking deepLinking = locator.get<DeepLinking>();
    return AnimatedSplashScreen.withScreenFunction(
      screenFunction: () async {
        await ref.read(moviesState).reloadMovies();
        deepLinking.state.listen((event) async {
          if (kDebugMode) {
            log(event);
          }
          Map parameters = Uri.parse(event).queryParameters;
          String route = Uri.parse(event).path;
          locator
              .get<NavigatorService>()
              .navigateTo(route, arguments: parameters["id"]);
        });
        locator.get<NotificationManager>().onForegroundNotification();
        return const MoviesView();
      },
      splash: Image.asset(
        "assets/splash_loading.gif",
      ),
    );
  }
}
