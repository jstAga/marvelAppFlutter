import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie/movie_entity.dart';
import 'package:marvel_app_flutter/ui/constants/bases/base_paging.dart';
import 'package:marvel_app_flutter/ui/constants/localized_model_storage.dart';
import 'package:marvel_app_flutter/ui/entity/movie/movie_ui.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/repository/movie_repository.dart';

class MoviesViewModel extends ChangeNotifier {
  MoviesViewModel() {
    _moviesPaging = BasePaging<MovieEntity>(load: (int nextPage) async {
      final result =
          await _moviesRepository.getMovies(nextPage, _localeStorage.localeTag);

      return BasePagingResponse(
          data: result.results,
          currentPage: result.page,
          totalPages: result.totalPages);
    });

    _searchMoviesPaging = BasePaging<MovieEntity>(load: (int nextPage) async {
      final result = await _moviesRepository.searchMovies(
          _searchQuery ?? "", nextPage, _localeStorage.localeTag);
      return BasePagingResponse(
          data: result.results,
          currentPage: result.page,
          totalPages: result.totalPages);
    });
  }

  late DateFormat _date;
  final _moviesRepository = MovieRepository();
  late final BasePaging<MovieEntity> _moviesPaging;
  late final BasePaging<MovieEntity> _searchMoviesPaging;
  var _movies = <MovieUi>[];
  final _localeStorage = LocalizedModelStorage();
  String? _searchQuery;
  Timer? searchTimer;

  List<MovieUi> get movies => _movies;

  String date(DateTime? releaseDate) =>
      releaseDate != null ? _date.format(releaseDate) : "";

  bool get isSearching {
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  void toDetail(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.pushNamed(context, MainNavigationRoutesNames.movieDetail,
        arguments: id);
  }

  Future<void> setupLocalization(Locale locale) async {
    if (!_localeStorage.updateLocale(locale)) return;
    _date = DateFormat.yMMMd(_localeStorage.localeTag);
    await _resetMovies();
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

  Future<void> _getNextPage() async {
    if (isSearching) {
      await _searchMoviesPaging.getNextPage();
      _movies = _searchMoviesPaging.data.map(_toMovieUi).toList();
    } else {
      await _moviesPaging.getNextPage();
      _movies = _moviesPaging.data.map(_toMovieUi).toList();
    }
    notifyListeners();
  }

  Future<void> _resetMovies() async {
    await _moviesPaging.reset();
    await _searchMoviesPaging.reset();
    _movies.clear();
    _getNextPage();
  }

  Future<void> searchMovies(String query) async {
    searchTimer?.cancel();
    searchTimer = Timer(const Duration(microseconds: 300), () async {
      final searchQuery = query.isNotEmpty ? query : null;
      if (searchQuery == _searchQuery) return;
      _searchQuery = searchQuery;
      _movies.clear();
      if (isSearching) {
        await _searchMoviesPaging.reset();
      }
      _getNextPage();
    });
  }

  void getCurrentMovieIndex(int index) {
    if (index < _movies.length - 1) return;
    _getNextPage();
  }
}
