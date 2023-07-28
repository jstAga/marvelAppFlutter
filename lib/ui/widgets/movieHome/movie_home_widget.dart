import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/app/app_view_model.dart';
import 'package:marvel_app_flutter/ui/core/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/core/movie_db_constants.dart';
import 'package:marvel_app_flutter/ui/widgets/movieHome/movie_home_model.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/movies_model.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/movies_widget.dart';


class MovieHomeWidget extends StatefulWidget {
  const MovieHomeWidget({Key? key}) : super(key: key);

  @override
  State<MovieHomeWidget> createState() => _MovieHomeWidgetState();
}

class _MovieHomeWidgetState extends State<MovieHomeWidget> {
  final movieModel = MoviesModel();
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<MovieHomeModel>(context);
    final appModel = InheritedProvider.read<AppViewModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieModel.setupLocalization(context);
  }

  void _onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieHomeModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(MovieDbConstants.theMovieDbHomeTitle),
        actions: [
          IconButton(
              onPressed: () => model?.onSessionExpired?.call(),
              // onPressed: () => logout,
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
          NotifierProvider(
            create: () => movieModel,
            isManagingModel: false,
            child: const Movies(),
          ),
          const Text("Home"),
          const Text("Tv shows")
        ],
      ),
    );
  }
}
