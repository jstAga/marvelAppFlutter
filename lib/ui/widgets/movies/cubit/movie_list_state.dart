part of 'movie_list_cubit.dart';

class MovieListState {
  final List<MovieUi> movies;
  final String localeTag;

  MovieListState({required this.movies, required this.localeTag});

  const MovieListState.initial()
      : movies = const <MovieUi>[],
        localeTag = "";

  MovieListState copyWith({
    List<MovieUi>? movies,
    String? localeTag,
  }) {
    return MovieListState(
      movies: movies ?? this.movies,
      localeTag: localeTag ?? this.localeTag,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MovieListState &&
              runtimeType == other.runtimeType &&
              movies == other.movies &&
              localeTag == other.localeTag;

  @override
  int get hashCode => movies.hashCode ^ localeTag.hashCode;
}
