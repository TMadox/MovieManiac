import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/Resources/constants_manager.dart';
import 'package:movies_app/core/util/injection.dart';
import 'package:movies_app/data/models/movie_details_model.dart';
import 'package:movies_app/service/repository/get_repo.dart';

final detailsState =
    ChangeNotifierProvider<DetailsViewmodel>((ref) => DetailsViewmodel());

class DetailsViewmodel extends ChangeNotifier {
  MovieDetailsModel? movie;

  Future<MovieDetailsModel?> getMovieDetails(String id) async {
    movie = MovieDetailsModel.fromJson(
      await locator.get<GetRepo>().get(
            ConstantsManager.movieDetailsPath + id,
          ),
    );
    return movie;
  }
}
