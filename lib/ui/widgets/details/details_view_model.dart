import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/data/core/network/api_client_exception.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_details/movie_details.dart';
import 'package:marvel_app_flutter/ui/constants/localized_model_storage.dart';
import 'package:marvel_app_flutter/ui/entity/movie_details/movie_details_ui.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_repository/auth_repository.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/repository/movie_repository.dart';

class DetailsViewModel extends ChangeNotifier {
  DetailsViewModel({required this.movieId});

  final _authRepository = AuthRepository();
  final _moviesRepository = MovieRepository();
  final int movieId;
  final _localeStorage = LocalizedModelStorage();
  var data = MovieDetailsUi();
  bool _isMovieSaved = false;

  Future<void> setupLocalization(BuildContext context, Locale locale) async {
    if (!_localeStorage.updateLocale(locale)) return;
    updateData(null, false);
    await _getDetails(context);
  }

  Future<void> _getDetails(BuildContext context) async {
    try {
      final details =
          await _moviesRepository.getDetails(movieId, _localeStorage.localeTag);
      _isMovieSaved = await _moviesRepository.isMovieSaved(movieId);

      updateData(details, _isMovieSaved);
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
    _isMovieSaved = !_isMovieSaved;
    data.changeSaveIcon(_isMovieSaved);
    notifyListeners();
    try {
      _moviesRepository.toggleSave(movieId, _isMovieSaved);
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
