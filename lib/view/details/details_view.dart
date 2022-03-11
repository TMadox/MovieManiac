import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/data/models/movie_details_model.dart';
import 'package:movies_app/view/details/details_viewmodel.dart';

class DetailsView extends ConsumerWidget {
  final String movieId;
  const DetailsView({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log(movieId);
    return FutureBuilder<MovieDetailsModel?>(
      future: ref.read(detailsState).getMovieDetails(movieId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.title.toString()),
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
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 121, 10, 212),
            ),
          );
        }
      },
    );
  }
}
