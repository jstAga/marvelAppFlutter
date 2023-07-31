import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/data/core/network/api_client_exception.dart';
import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';
import 'package:marvel_app_flutter/data/remote/api_client/movies_api_client.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_details/movie_details.dart';
import 'package:marvel_app_flutter/data/core/network/configurations.dart';
import 'package:marvel_app_flutter/ui/entity/movie_details/movie_details_ui.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_repository/auth_repository.dart';

class DetailsViewModel extends ChangeNotifier {
  DetailsViewModel({required this.movieId});

  final _authRepository = AuthRepository();
  var data = MovieDetailsUi();
  final _apiClient = MoviesApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final int movieId;
  MovieDetailsEntity? _movieDetails;
  String _local = "ru-Ru";
  bool _isMovieSaved = false;

  MovieDetailsEntity? get movieDetails => _movieDetails;

  bool get isMovieSaved => _isMovieSaved;

  Future<void> setupLocalization(BuildContext context) async {
    final local = Localizations.localeOf(context).toLanguageTag();
    if (_local == local) return;
    _local = local;
    updateData(null, false);
    await _getDetails(context);
  }

  Future<void> _getDetails(BuildContext context) async {
    try {
      _movieDetails = await _apiClient.getDetails(movieId, _local);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isMovieSaved = await _apiClient.isMovieSaved(movieId, sessionId);
      }
      updateData(_movieDetails, _isMovieSaved);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void updateData(MovieDetailsEntity? details, bool isMovieSaved) {
    data = MovieDetailsUi.toUiFromEntity(details, isMovieSaved);
    if (details == null) {
      data = MovieDetailsUi.toUiFromEntity(details, isMovieSaved);
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  Future<void> toggleSave(BuildContext context) async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (sessionId == null || accountId == null) return;

    _isMovieSaved = !_isMovieSaved;
    notifyListeners();
    updateData(_movieDetails, isMovieSaved);
    try {
      await _apiClient.saveMovie(
          accountId: accountId,
          sessionId: sessionId,
          mediaType: MediaType.movie,
          mediaId: movieId,
          isSaved: _isMovieSaved);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  Future<void> _handleApiClientException(
      ApiClientException e, BuildContext context) async {
    switch (e.type) {
      case ApiClientExceptionType.sessionExpired:
        _authRepository.logout();
        MainNavigation.resetNavigation(context);
        break;
      default:
        break;
    }
  }
}
