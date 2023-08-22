import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_bloc.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_state.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/cubit/auth_view_cubit.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/cubit/auth_view_cubit_state.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/home/home_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/home/home_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/movies_view_model.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/movies_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/splash_screen/loader_view_cubit.dart';
import 'package:marvel_app_flutter/ui/widgets/splash_screen/loader_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/trailer/trailer_widget.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  AuthBloc? _authBloc;

  Widget createSplashScreenWidget() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckInProgressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (context) =>
          LoaderViewCubit(authBloc, LoaderViewCubitState.unknown),
      child: const LoaderWidget(),
    );
  }

  Widget createAuthWidget() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckInProgressState());
    _authBloc = authBloc;
    return BlocProvider<AuthViewCubit>(
      create: (_) => AuthViewCubit(AuthViwCubitFormInProgressState(), authBloc),
      child: const AuthWidget(),
    );
  }

  Widget createHomeWidget() {
    _authBloc?.close();
    _authBloc = null;
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const HomeWidget(),
    );
  }

  Widget createMovieDetailsWidget(int movieId) {
    return ChangeNotifierProvider(
        create: (_) => DetailsViewModel(movieId: movieId),
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
