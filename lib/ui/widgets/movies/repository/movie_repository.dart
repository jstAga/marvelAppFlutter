import 'package:marvel_app_flutter/data/remote/api_client/movies_api_client.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_response/movie_response.dart';

class MovieRepository {
  final _moviesApiClient = MoviesApiClient();

  Future<MovieResponse> getMovies(int nextPage, String local) async =>
       await _moviesApiClient.getMovies(nextPage, local);

  Future<MovieResponse> searchMovies(
          String query, int page, String local) async =>
      await _moviesApiClient.searchMovies(query, page, local);
}
