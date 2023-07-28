import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marvel_app_flutter/data/remote/api_client/movies_api_client.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie/movie_entity.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_response/movie_response.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';

class MoviesModel extends ChangeNotifier {
  final _apiClient = MoviesApiClient();
  final _movies = <MovieEntity>[];
  late DateFormat _date;
  late int _currentPage;
  late int _totalPages;
  bool _isLoading = false;
  String _local = "";
  String? _searchQuery;
  Timer? searchTimer;

  List<MovieEntity> get movies => _movies;

  String date(DateTime? releaseDate) =>
      releaseDate != null ? _date.format(releaseDate) : "";

  void toDetail(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.pushNamed(context, MainNavigationRoutesNames.movieDetail,
        arguments: id);
  }

  Future<void> setupLocalization(BuildContext context) async {
    final local = Localizations.localeOf(context).toLanguageTag();
    if (_local == local) return;
    _local = local;
    _date = DateFormat.yMMMd(local);
    await _resetMovies();
  }

  Future<MovieResponse> _getMovies(int nextPage, String local) async {
    if (_searchQuery == null) {
      return await _apiClient.getMovies(nextPage, _local);
    } else {
      return await _apiClient.searchMovies(_searchQuery!, nextPage, local);
    }
  }

  Future<void> _getNextPage() async {
    if (_isLoading || _currentPage >= _totalPages) return;
    _isLoading = true;
    final nextPage = _currentPage + 1;
    try {
      final moviesResponse = await _getMovies(nextPage, _local);
      _movies.addAll(moviesResponse.results);
      notifyListeners();
      _currentPage = moviesResponse.page;
      _totalPages = moviesResponse.totalPages!;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> _resetMovies() async {
    _currentPage = 0;
    _totalPages = 1;
    movies.clear();
    await _getNextPage();
  }

  Future<void> searchMovies(String query) async {
    searchTimer?.cancel();
    searchTimer = Timer(const Duration(microseconds: 300), () async {
      final searchQuery = query.isNotEmpty ? query : null;
      if (searchQuery == _searchQuery) return;
      _searchQuery = searchQuery;
      await _resetMovies();
    });
  }

  void getCurrentMovieIndex(int index) {
    if (index < _movies.length - 1) return;
    _getNextPage();
  }
}
