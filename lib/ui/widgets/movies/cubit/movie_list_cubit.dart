import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:marvel_app_flutter/blocs/movies_bloc/movies_bloc.dart';
import 'package:marvel_app_flutter/blocs/movies_bloc/movies_events.dart';
import 'package:marvel_app_flutter/blocs/movies_bloc/movies_state.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie/movie_entity.dart';
import 'package:marvel_app_flutter/ui/entity/movie/movie_ui.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  Timer? searchTimer;
  late DateFormat _date;
  final MoviesBloc moviesBloc;
  late final StreamSubscription<MoviesState> movieListSubscription;

  MovieListCubit({required this.moviesBloc})
      : super(const MovieListState.initial()) {
    Future.microtask(() {
      _onState(moviesBloc.state);
      movieListSubscription = moviesBloc.stream.listen(_onState);
    });
  }

  void _onState(MoviesState state) {
    final movies = state.movies.map(_toMovieUi).toList();
    final newState = this.state.copyWith(movies: movies);
    emit(newState);
  }

  void searchMovie(String query) {
    searchTimer?.cancel();
    searchTimer = Timer(const Duration(microseconds: 300), () async {
      moviesBloc.add(MoviesSearchPageEvent(query: query));
      moviesBloc.add(MoviesLoadNextPageEvent(locale: state.localeTag));
    });
  }

  void setupLocale(String localeTag) {
    if (state.localeTag == localeTag) return;
    final newState = state.copyWith(localeTag: localeTag);
    emit(newState);
    _date = DateFormat.yMMMd(localeTag);
    moviesBloc.add(MoviesResetPageEvent());
    moviesBloc.add(MoviesLoadNextPageEvent(locale: localeTag));
  }

  @override
  Future<void> close() {
    movieListSubscription.cancel();
    return super.close();
  }

  void getCurrentMovieIndex(int index) {
    moviesBloc.add(MoviesLoadNextPageEvent(locale: state.localeTag));
  }

  MovieUi _toMovieUi(MovieEntity movie) {
    final releaseDate = movie.releaseDate;
    final releaseDateTitle =
        releaseDate != null ? _date.format(releaseDate) : "";
    return MovieUi(
        title: movie.title,
        releaseDate: releaseDateTitle,
        overview: movie.overview,
        image: movie.image,
        id: movie.id);
  }
}
