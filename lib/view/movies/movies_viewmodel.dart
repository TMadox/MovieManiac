import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/Resources/constants_manager.dart';
import 'package:movies_app/core/util/injection.dart';
import 'package:movies_app/data/models/movies_model.dart';
import 'package:movies_app/service/repository/get_repo.dart';
import 'package:movies_app/service/response/movies_response.dart';

final moviesState =
    ChangeNotifierProvider<MoviesViewmodel>((ref) => MoviesViewmodel());

class MoviesViewmodel extends ChangeNotifier {
  List<Movies> moviesList = [];
  MoviesResponse? currentResponse;
  Future<void> loadMoreMovies(int index) async {
    MoviesResponse moviesResponse = MoviesResponse.fromJson(
      await locator.get<GetRepo>().get(
        ConstantsManager.topRatedMoviesPath,
        queryParameters: {"page": index},
      ),
    );
    currentResponse = moviesResponse;
    moviesList.addAll(moviesResponse.results ?? []);
    notifyListeners();
  }

  Future<bool> reloadMovies() async {
    MoviesResponse moviesResponse = MoviesResponse.fromJson(
      await locator.get<GetRepo>().get(
        ConstantsManager.topRatedMoviesPath,
        queryParameters: {"page": 1},
      ),
    );
    currentResponse = moviesResponse;
    moviesList = List.from(moviesResponse.results ?? []);
    notifyListeners();
    return true;
  }
}
