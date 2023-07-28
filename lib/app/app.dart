import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marvel_app_flutter/app/app_view_model.dart';
import 'package:marvel_app_flutter/ui/core/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/core/movie_db_constants.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final _mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    final model = InheritedProvider.read<AppViewModel>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: _mainNavigation.initialRoute(model?.isAuth == true),
      routes: _mainNavigation.routes,
      onGenerateRoute: _mainNavigation.onGenerateRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru', "RU"),
      ],
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: MovieDbConstants.theMovieDbBackground),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              backgroundColor: MovieDbConstants.theMovieDbBackground)),
    );
  }
}
