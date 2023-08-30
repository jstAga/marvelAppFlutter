import 'package:marvel_app_flutter/data/remote/entity/movie/movie_entity.dart';

class MoviesState {
  final MoviesDataContainer allMovies;
  final MoviesDataContainer searchMovies;
  final String query;

  MoviesState({
    required this.allMovies,
    required this.searchMovies,
    required this.query,
  });

  const MoviesState.initial()
      : allMovies = const MoviesDataContainer.initial(),
        searchMovies = const MoviesDataContainer.initial(),
        query = "";

  bool get isSearching => query.isNotEmpty;

  List<MovieEntity> get movies =>
      isSearching ? searchMovies.movies : allMovies.movies;

  MoviesState copyWith({
    MoviesDataContainer? allMovies,
    MoviesDataContainer? searchMovies,
    String? query,
  }) {
    return MoviesState(
      allMovies: allMovies ?? this.allMovies,
      searchMovies: searchMovies ?? this.searchMovies,
      query: query ?? this.query,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesState &&
          runtimeType == other.runtimeType &&
          allMovies == other.allMovies &&
          searchMovies == other.searchMovies &&
          query == other.query;

  @override
  int get hashCode =>
      allMovies.hashCode ^ searchMovies.hashCode ^ query.hashCode;
}

class MoviesDataContainer {
  final List<MovieEntity> movies;
  final int currentPage;
  final int totalPage;

  MoviesDataContainer({
    required this.movies,
    required this.currentPage,
    required this.totalPage,
  });

  const MoviesDataContainer.initial()
      : movies = const <MovieEntity>[],
        currentPage = 0,
        totalPage = 1;

  bool get isComplete => currentPage >= totalPage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesDataContainer &&
          runtimeType == other.runtimeType &&
          movies == other.movies;

  @override
  int get hashCode => movies.hashCode;

  MoviesDataContainer copyWith({
    List<MovieEntity>? movies,
    int? currentPage,
    int? totalPage,
  }) {
    return MoviesDataContainer(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
    );
  }
}
