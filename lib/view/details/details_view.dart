import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/Resources/constants_manager.dart';
import 'package:movies_app/core/Resources/screen_size.dart';
import 'package:movies_app/data/models/movie_details_model.dart';
import 'package:movies_app/view/details/details_viewmodel.dart';

class DetailsView extends ConsumerWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsRef = ref.read(detailsState);
    final double height = screenHeight(context);
    final double width = screenWidth(context);
    final double fontRatio = screenWidth(context) / screenHeight(context);
    return FutureBuilder<MovieDetailsModel?>(
      future: ref.read(detailsState).getMovieDetails(Get.arguments.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(snapshot.data!.originalTitle.toString()),
            ),
            body: Column(
              children: [
                ListTile(
                  title: Text(
                    snapshot.data!.title!.toString(),
                    style: TextStyle(fontSize: width / height * 40),
                  ),
                  subtitle: Text(snapshot.data!.releaseDate!.toString() +
                      "  " +
                      detailsRef.formatHHMMSS(snapshot.data!.runtime!) +
                      "  " +
                      snapshot.data!.originalLanguage.toString()),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: height * 0.3,
                    viewportFraction: 1,
                  ),
                  items: detailsRef.images!.backdrops.map(
                    (poster) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: ConstantsManager.imageBaseUrl +
                                  poster.filePath,
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: height * 0.25,
                  width: width * 0.95,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          width: width * 0.3,
                          fit: BoxFit.cover,
                          imageUrl: ConstantsManager.imageBaseUrl +
                              detailsRef.images!.posters[0].filePath,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: snapshot.data!.genres!
                                    .map(
                                      (e) => Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: const EdgeInsets.only(
                                          right: 5,
                                          bottom: 5,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          e.name.toString(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                snapshot.data!.overview.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Container(
                  height: screenHeight(context) * 0.12,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 239, 182, 41),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: snapshot.data!.voteAverage.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontRatio * 30),
                                ),
                                const TextSpan(text: "/10")
                              ],
                            ),
                          ),
                          Text(
                            detailsRef.formatNumber(snapshot.data!.voteCount!),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 239, 182, 41),
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                                snapshot.data!.popularity!.toStringAsFixed(1)),
                          ),
                          const Text(
                            "Popularity",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text("an error occured"),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 121, 10, 212),
              ),
            ),
          );
        }
      },
    );
  }
}
