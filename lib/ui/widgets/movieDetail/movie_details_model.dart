import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/data/core/network/api_client_exception.dart';
import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';
import 'package:marvel_app_flutter/data/remote/api_client/movies_api_client.dart';
import 'package:marvel_app_flutter/data/remote/entity/detail_movie/movie_details.dart';
import 'package:marvel_app_flutter/data/core/network/configurations.dart';


class MovieDetailsModel extends ChangeNotifier {
  MovieDetailsModel({required this.movieId});

  final _apiClient = MoviesApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final int movieId;
  MovieDetailsEntity? _movieDetails;
  String _local = "ru-Ru";
  bool _isMovieSaved = false;
  Future<void>? Function()? onSessionExpired;

  MovieDetailsEntity? get movieDetails => _movieDetails;

  bool get isMovieSaved => _isMovieSaved;

  Future<void> setupLocalization(BuildContext context) async {
    final local = Localizations.localeOf(context).toLanguageTag();
    if (_local == local) return;
    _local = local;
    await _getDetails();
  }

  Future<void> _getDetails() async {
    try {
      _movieDetails = await _apiClient.getDetails(movieId, _local);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isMovieSaved = await _apiClient.isMovieSaved(movieId, sessionId);
      }
      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> toggleSave() async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (sessionId == null || accountId == null) return;
    final isMovieSavedUpdated = !_isMovieSaved;
    _isMovieSaved = isMovieSavedUpdated;
    notifyListeners();

    try {
      await _apiClient.saveMovie(
          accountId: accountId,
          sessionId: sessionId,
          mediaType: MediaType.movie,
          mediaId: movieId,
          isSaved: isMovieSavedUpdated);
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException e) {
    switch (e.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
        break;
      default:
        print(e);
        break;
    }
  }
}
