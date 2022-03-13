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
            Padding(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  height: screenHeight(context) * 0.16,
                  imageUrl: ConstantsManager.imageBaseUrl +
                      movie.backdropPath.toString(),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                isThreeLine: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                title: Text(
                  movie.title.toString(),
                ),
                subtitle: AutoSizeText(
                  movie.overview.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
