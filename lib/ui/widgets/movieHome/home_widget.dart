import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';
import 'package:marvel_app_flutter/ui/constants/screen_factory/screen_factory.dart';
import 'package:marvel_app_flutter/ui/core/movie_db_constants.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _screenFactory = ScreenFactory();
  int _selectedTab = 0;

  void _onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MovieDbConstants.theMovieDbHomeTitle),
        actions: [
          IconButton(
              onPressed: () => SessionDataProvider().setSessionId(null),
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie, color: Colors.white), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV shows")
        ],
        onTap: _onSelectedTab,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.createMoviesWidget(),
          _screenFactory.createFavoritesWidget(),
          _screenFactory.createComicsWidget(),
        ],
      ),
    );
  }
}
