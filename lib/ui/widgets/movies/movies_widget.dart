import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/ui/constants/constants.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/movies_view_model.dart';
import 'package:provider/provider.dart';

class MoviesWidget extends StatefulWidget {
  const MoviesWidget({Key? key}) : super(key: key);

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MoviesViewModel>().setupLocalization(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [_MovieListBuilder(), _Search()],
    );
  }
}

class _MovieListBuilder extends StatelessWidget {
  const _MovieListBuilder();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MoviesViewModel>();

    return ListView.builder(
        padding: const EdgeInsets.only(top: 70),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: viewModel.movies.length,
        itemExtent: 163,
        itemBuilder: (BuildContext context, int index) {
          viewModel.getCurrentMovieIndex(index);
          return _MovieItem(index: index);
        });
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: MovieDbConstants.movieCardDecoration,
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                _MoviePoster(index: index),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MovieTitle(index: index),
                        const SizedBox(height: 5),
                        _MovieDate(index: index),
                        const SizedBox(height: 10),
                        _MovieOverview(index: index),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _ItemBackground(index: index)
        ],
      ),
    );
  }
}

class _ItemBackground extends StatelessWidget {
  const _ItemBackground({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MoviesViewModel>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => viewModel.toDetail(context, index),
      ),
    );
  }
}

class _MovieDate extends StatelessWidget {
  const _MovieDate({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MoviesViewModel>();
    final movie = viewModel.movies[index];
    return Text(
      movie.releaseDate ?? "",
      maxLines: 1,
      style: const TextStyle(color: Colors.grey),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MoviesViewModel>();
    final movie = viewModel.movies[index];
    return Image.network(
      movie.image ?? "",
      width: 95,
    );
  }
}

class _MovieOverview extends StatelessWidget {
  const _MovieOverview({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MoviesViewModel>();
    final movie = viewModel.movies[index];
    return Text(
      movie.overview ?? "No description",
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _MovieTitle extends StatelessWidget {
  const _MovieTitle({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MoviesViewModel>();
    final movie = viewModel.movies[index];
    return Text(movie.title ?? "No title",
        maxLines: 1,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
  }
}

class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MoviesViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextField(
        onChanged: viewModel.searchMovies,
        // controller: _searchController,
        decoration: InputDecoration(
            labelText: "Search",
            isDense: true,
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.blueAccent,
            ),
            fillColor: Colors.white.withOpacity(0.8),
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
