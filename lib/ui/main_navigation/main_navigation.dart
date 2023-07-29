import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/ui/constants/screen_factory/screen_factory.dart';

abstract class MainNavigationRoutesNames {
  static const splashScreen = "/splash";
  static const authMovieDb = "/authTheMovieDB";
  static const homeMovieDb = "/homeTheMovieDB";
  static const movieDetail = "/homeTheMovieDB/movieDetail";
  static const movieTrailer = "/homeTheMovieDB/movieDetail/trailer";
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesNames.splashScreen: (_) =>
        _screenFactory.createSplashScreenWidget(),
    MainNavigationRoutesNames.authMovieDb: (_) =>
        _screenFactory.createAuthWidget(),
    MainNavigationRoutesNames.homeMovieDb: (_) =>
        _screenFactory.createHomeWidget()
  };

  Route<Object>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutesNames.movieDetail:
        final args = settings.arguments;
        final movieId = args is int ? args : 0;
        return MaterialPageRoute(builder: (_) {
          return _screenFactory.createMovieDetailsWidget(movieId);
        });
      case MainNavigationRoutesNames.movieTrailer:
        return MaterialPageRoute(builder: (_) {
          final args = settings.arguments;
          final trailerKey = args is String ? args : "";
          return _screenFactory.createMovieTrailerWidget(trailerKey);
        });
    }
    return null;
  }

  static void resetNavigation(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, MainNavigationRoutesNames.splashScreen, (route) => false);
  }
}
