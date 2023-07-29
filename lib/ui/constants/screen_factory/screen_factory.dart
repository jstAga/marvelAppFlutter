import 'package:flutter/cupertino.dart';
import 'package:marvel_app_flutter/ui/constants/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/home/home_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/home/home_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/movies_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/movies_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/splash_screen/splash_screen_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/splash_screen/splash_screen_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/trailer/trailer_widget.dart';
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
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthWidget(),
    );
  }

  Widget createHomeWidget() {
    return NotifierProvider(
      create: () => HomeViewModel(),
      child: const HomeWidget(),
    );
  }

  Widget createMovieDetailsWidget(int movieId) {
    return NotifierProvider(
        create: () => DetailsViewModel(movieId: movieId),
        child: const DetailsWidget());
  }

  Widget createMovieTrailerWidget(String trailerKey) {
    return TrailerWidget(trailerKey: trailerKey);
  }

  Widget createMoviesWidget() {
    return ChangeNotifierProvider(
      create: (_) => MoviesViewModel(),
      child: const MoviesWidget(),
    );
  }

  Widget createFavoritesWidget() {
    return const Text("Favorites");
  }

  Widget createComicsWidget() {
    return const Text("Comics");
  }
}
