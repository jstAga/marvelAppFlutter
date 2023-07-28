import 'package:flutter/cupertino.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_repository/auth_repository.dart';

class SplashScreenViewModel {
  SplashScreenViewModel(this.context) {
    asyncInit();
  }

  final _authRepository = AuthRepository();
  final BuildContext context;

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authRepository.isAuth();
    final nextScreen = isAuth
        ? MainNavigationRoutesNames.homeMovieDb
        : MainNavigationRoutesNames.authMovieDb;
    Navigator.pushReplacementNamed(context, nextScreen);
  }
}
