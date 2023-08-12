import 'package:marvel_app_flutter/data/core/network/configurations.dart';
import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';
import 'package:marvel_app_flutter/data/remote/api_client/account_api_client.dart';
import 'package:marvel_app_flutter/data/remote/api_client/movies_api_client.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_details/movie_details.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_response/movie_response.dart';

class MovieRepository {
  final _moviesApiClient = MoviesApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final _accountApiClient = AccountApiClient();

  Future<MovieResponse> getMovies(int nextPage, String local) async =>
      await _moviesApiClient.getMovies(nextPage, local);

  Future<MovieResponse> searchMovies(
          String query, int page, String local) async =>
      await _moviesApiClient.searchMovies(query, page, local);

  Future<MovieDetailsEntity> getDetails(int movieId, String local) async {
    final movieDetails = await _moviesApiClient.getDetails(movieId, local);

    return movieDetails;
  }

  Future<bool> isMovieSaved(int movieId) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    var isMovieSaved = false;
    if (sessionId != null) {
      isMovieSaved = await _moviesApiClient.isMovieSaved(movieId, sessionId);
    }
    return isMovieSaved;
  }

  Future<void> toggleSave(int movieId, bool isMovieSaved) async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (sessionId == null || accountId == null) return;

    await _moviesApiClient.saveMovie(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: MediaType.movie,
        mediaId: movieId,
        isSaved: isMovieSaved);
  }
}
