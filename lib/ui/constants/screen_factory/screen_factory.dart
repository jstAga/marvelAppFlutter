import 'package:flutter/cupertino.dart';
import 'package:marvel_app_flutter/ui/core/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_model.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/movieDetail/movie_details.dart';
import 'package:marvel_app_flutter/ui/widgets/movieDetail/movie_details_model.dart';
import 'package:marvel_app_flutter/ui/widgets/movieHome/movie_home_model.dart';
import 'package:marvel_app_flutter/ui/widgets/movieHome/movie_home_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/movieTrailer/movie_trailer_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/splash_screen/splash_screen_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/splash_screen/splash_screen_widget.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget createSplashScreenWidget() {
    return Provider(
      create: (context) => SplashScreenViewModel(context),
      lazy: false,
      child: const SplashScreenWidget(),
    );
  }

  Widget createAuthWidget() {
    return NotifierProvider(
      create: () => AuthModel(),
      child: const AuthWidget(),
    );
  }

  Widget createHomeWidget() {
    return NotifierProvider(
      create: () => MovieHomeModel(),
      child: const MovieHomeWidget(),
    );
  }

  Widget createMovieDetailsWidget(int movieId) {
    return NotifierProvider(
        create: () => MovieDetailsModel(movieId: movieId),
        child: const MovieDetailsWidget());
  }

  Widget createMovieTrailerWidget(String trailerKey) {
    return MovieTrailerWidget(trailerKey: trailerKey);
  }
}
