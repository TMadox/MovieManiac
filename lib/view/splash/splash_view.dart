import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/Resources/routes_manager.dart';
// import 'package:movies_app/core/util/injection.dart';
// import 'package:movies_app/core/util/navigator.dart';
import 'package:movies_app/view/details/details_view.dart';
import 'package:movies_app/view/movies/movies_view.dart';
import 'package:movies_app/view/movies/movies_viewmodel.dart';

class SplashView extends ConsumerWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSplashScreen.withScreenFunction(
        screenFunction: () async {
          await ref.read(moviesState).reloadMovies();
          if (Get.parameters["next_route"] != null) {
            final params = Get.parameters;
            Get.offNamed(Routes.moviesRoute);
            await Get.toNamed(params["next_route"].toString(),
                arguments: params["movie_id"]);
            return const DetailsView();
          } else {
            return const MoviesView();
          }
        },
        disableNavigation: true,
        duration: 0,
        splash: Text((Get.parameters["next_route"] != null).toString())
        // splash: Image.asset(
        //   "assets/splash_loading.gif",
        // ),

        );
  }
}
