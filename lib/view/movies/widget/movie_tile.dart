import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/Resources/constants_manager.dart';
import 'package:movies_app/core/Resources/routes_manager.dart';
import 'package:movies_app/core/Resources/screen_size.dart';
// import 'package:movies_app/core/util/injection.dart';
// import 'package:movies_app/core/util/navigator.dart';
import 'package:movies_app/data/models/movies_model.dart';

class MovieTile extends StatelessWidget {
  final Movies movie;
  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.detailsRoute, arguments: movie.id);
        // locator
        //     .get<NavigatorService>()
        //     .navigateTo(Routes.detailsRoute, arguments: movie.id.toString());
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageBuilder: (context, image) {
                  return Container(
                      decoration: BoxDecoration(
                    image: DecorationImage(image: image, fit: BoxFit.cover),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ));
                },
                imageUrl: ConstantsManager.imageBaseUrl +
                    movie.backdropPath.toString(),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    movie.title.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: AutoSizeText(
                        movie.overview.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
