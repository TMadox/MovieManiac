import 'package:flutter/material.dart';
import 'package:movies_app/core/Resources/strings_manager.dart';
import 'package:movies_app/data/models/details_arguments_model.dart';
import 'package:movies_app/view/details/details_view.dart';
import 'package:movies_app/view/movies/movies_view.dart';
import 'package:movies_app/view/splash/splash_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String moviesRoute = '/movies';
  static const String detailsRoute = '/details';
}

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case Routes.splashRoute:
//         {
//           DetailsArgumentsModel? args;
//           if (routeSettings.arguments == null) {
//             args = routeSettings.arguments as DetailsArgumentsModel;
//           }
//           return MaterialPageRoute(
//             builder: (_) => SplashView(
//               param: args,
//             ),
//           );
//         }

//       case Routes.moviesRoute:
//         return MaterialPageRoute(builder: (_) => const MoviesView());
//       case Routes.detailsRoute:
//         return MaterialPageRoute(
//             builder: (_) => DetailsView(
//                   movieId: routeSettings.arguments as String,
//                 ));
//       default:
//         return unDefinedRoute();
//     }
//   }

//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(
//           title: Text(StringsManager.unknownRoute),
//         ),
//         body: Center(child: Text(StringsManager.unknownRoute)),
//       ),
//     );
//   }
// }
