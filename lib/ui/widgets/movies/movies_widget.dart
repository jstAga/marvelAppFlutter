import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie/movie_entity.dart';
import 'package:marvel_app_flutter/ui/core/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/core/movie_db_constants.dart';
import 'package:marvel_app_flutter/ui/widgets/movies/movies_model.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MoviesModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: model.movies.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              model.getCurrentMovieIndex(index);
              final movie = model.movies[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      decoration: MovieDbConstants.movieCardDecoration,
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        children: [
                          Image.network(
                            movie.image,
                            width: 95,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Title(movie: movie),
                                  const SizedBox(height: 5),
                                  Text(
                                    model.date(movie.releaseDate),
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 10),
                                  _Overview(movie: movie),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => model.toDetail(context, index),
                      ),
                    )
                  ],
                ),
              );
            }),
         _Search(model: model)
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Text(
      movie.overview ?? "No description",
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Text(movie.title ?? "No title",
        maxLines: 1,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
  }
}

class _Search extends StatelessWidget {
  const _Search({required this.model});

  final MoviesModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextField(
        onChanged: model.searchMovies,
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
