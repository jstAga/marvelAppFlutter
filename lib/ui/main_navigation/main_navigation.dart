import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/ui/core/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_model.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/movieDetail/movie_details.dart';
import 'package:marvel_app_flutter/ui/widgets/movieDetail/movie_details_model.dart';
import 'package:marvel_app_flutter/ui/widgets/movieHome/movie_home_model.dart';
import 'package:marvel_app_flutter/ui/widgets/movieHome/movie_home_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/movieTrailer/movie_trailer_widget.dart';


abstract class MainNavigationRoutesNames {
  //the movie db
  static const authMovieDb = "authTheMovieDB";
  static const homeMovieDb = "homeTheMovieDB";
  static const movieDetail = "homeTheMovieDB/movieDetail";
  static const movieTrailer = "homeTheMovieDB/movieDetail/trailer";
}

class MainNavigation {

  String initialRoute(bool isAuth) => isAuth //movieDb
      ? MainNavigationRoutesNames.homeMovieDb
      : MainNavigationRoutesNames.authMovieDb;

  final routes = <String, Widget Function(BuildContext)>{
    //movieDb
    MainNavigationRoutesNames.authMovieDb: (context) =>
        NotifierProvider(create: () => AuthModel(), child: const AuthWidget()),
    MainNavigationRoutesNames.homeMovieDb: (context) => NotifierProvider(
        create: () => MovieHomeModel(), child: const MovieHomeWidget()),

  };

  Route<Object>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //movieDb
      case MainNavigationRoutesNames.movieDetail:
        final args = settings.arguments;
        final movieId = args is int ? args : 0;
        return MaterialPageRoute(builder: (context) {
          return NotifierProvider(
              create: () => MovieDetailsModel(movieId: movieId),
              child: const MovieDetailsWidget());
        });
      case MainNavigationRoutesNames.movieTrailer:
        return MaterialPageRoute(builder: (context) {
          final args = settings.arguments;
          final trailerKey = args is String ? args : "";
          return MovieTrailerWidget(
            trailerKey: trailerKey,
          );
        });

    }
  }
}
