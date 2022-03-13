import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/core/Resources/constants_manager.dart';
import 'package:movies_app/core/util/injection.dart';
import 'package:movies_app/data/models/movie_details_model.dart';
import 'package:movies_app/data/models/movie_images_model.dart';
import 'package:movies_app/service/repository/get_repo.dart';

final detailsState =
    ChangeNotifierProvider<DetailsViewmodel>((ref) => DetailsViewmodel());

class DetailsViewmodel extends ChangeNotifier {
  MovieDetailsModel? movie;
  MovieImagesModel? images;
  Future<MovieDetailsModel?> getMovieDetails(String id) async {
    movie = MovieDetailsModel.fromJson(
      await locator.get<GetRepo>().get(
            ConstantsManager.movieDetailsPath + id,
          ),
    );
    images = MovieImagesModel.fromJson(
      await locator.get<GetRepo>().get(
            ConstantsManager.movieDetailsPath +
                id +
                ConstantsManager.movieImagesPath,
          ),
    );
    return movie;
  }

  String formatHHMMSS(int seconds) {
    if (seconds != 0) {
      int hours = (seconds / 3600).truncate();
      seconds = (seconds % 3600).truncate();
      int minutes = (seconds / 60).truncate();

      String hoursStr = (hours).toString().padLeft(2, '0');
      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      if (hours == 0) {
        return "$minutesStr:$secondsStr";
      }
      return "$hoursStr:$minutesStr:$secondsStr";
    } else {
      return "";
    }
  }

  String formatNumber(int input) {
    final form = NumberFormat("###,###", "en_US");
    return form.format(input);
  }
}
