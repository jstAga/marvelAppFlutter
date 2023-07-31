import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marvel_app_flutter/ui/constants/constants.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final _mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: MainNavigationRoutesNames.splashScreen,
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
