import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movies_app/view/details/details_viewmodel.dart';
import 'package:movies_app/view/movies/movies_viewmodel.dart';
import 'package:movies_app/view/movies/widget/movie_tile.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoviesView extends ConsumerStatefulWidget {
  const MoviesView({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesViewState();
}

class _MoviesViewState extends ConsumerState<MoviesView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    final movieRef = ref.read(moviesState);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Movies"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      }),
      body: AnimationLimiter(
        child: SmartRefresher(
          primary: true,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: ref.watch(moviesState).moviesList.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                      child: MovieTile(
                    movie: movieRef.moviesList[index],
                  )),
                ),
              );
            },
          ),
          onRefresh: () async {
            await movieRef.reloadMovies();
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
            await movieRef.loadMoreMovies(movieRef.currentResponse!.page! + 1);
            _refreshController.loadComplete();
          },
          enablePullUp: true,
          controller: _refreshController,
        ),
      ),
    );
  }
}
