import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/data/remote/entity/credits/credits_entity.dart';
import 'package:marvel_app_flutter/ui/core/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/core/bases_ext.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/movieDetail/movie_details_model.dart';

class MovieDetailsMainInfo extends StatelessWidget {
  const MovieDetailsMainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _TopPoster(),
      Padding(padding: const EdgeInsets.all(20), child: _MovieName()),
      const _Score(),
      const _MovieInfo(),
      const _Overview(),
      const _Description(),
      const _CrewInfo()
    ]);
  }
}

class _Score extends StatelessWidget {
  const _Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final voteAverage = movieDetails?.voteAverage ?? 0;
    final videos = movieDetails?.videos?.results
        .where((video) => video.type == "Trailer" && video.site == "YouTube");
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;

    final score = (voteAverage * 10).round() / 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Text("$score / 10 User Score",
                style: BaseTextStyle.baseSimilarBoldText(Colors.lightBlue))),
        Container(width: 1, height: 15, color: Colors.white),
        trailerKey != null
            ? TextButton(
                onPressed: () => Navigator.pushNamed(
                    context, MainNavigationRoutesNames.movieTrailer,
                    arguments: trailerKey),
                child: Text("Play Trailer",
                    style: BaseTextStyle.baseSimilarBoldText(Colors.lightBlue)))
            : const SizedBox.shrink()
      ],
    );
  }
}

class _CrewInfo extends StatelessWidget {
  const _CrewInfo();

  @override
  build(BuildContext context) {
    final List<List<Crew>> crewChunks =
        NotifierProvider.watch<MovieDetailsModel>(context)
            ?.movieDetails
            ?.crewChunks;

    return Column(
      children: crewChunks
          .map((chunk) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _CrewRow(crewList: chunk),
              ))
          .toList(),
    );
  }
}

class _CrewRow extends StatelessWidget {
  const _CrewRow({required this.crewList});

  final List<Crew> crewList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          children: crewList.map((crew) => _CrewRowItem(crew: crew)).toList()),
    );
  }
}

class _CrewRowItem extends StatelessWidget {
  const _CrewRowItem({required this.crew});

  final Crew crew;

  @override
  Widget build(BuildContext context) {
    const jobStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(crew.name ?? "",
              style: BaseTextStyle.baseSimilarText(Colors.white)),
          Text(crew.job ?? "", style: jobStyle),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    final model =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(model?.overview ?? "",
          style: BaseTextStyle.baseSimilarText(Colors.white)),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          "Overview",
          style: BaseTextStyle.baseTitleText(Colors.white),
        ));
  }
}

class _TopPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdrop;
    final posterPath = model?.movieDetails?.poster;
    final saveIcon = model!.isMovieSaved == true
        ? const Icon(Icons.bookmark, color: Colors.yellow)
        : const Icon(Icons.bookmark_add, color: Colors.white);

    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(backdropPath,
                  width: double.infinity, fit: BoxFit.fitWidth)
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: Image.network(posterPath),
          ),
          Positioned(
              top: 20,
              right: 5,
              child: IconButton(
                icon: saveIcon,
                onPressed: () => model.toggleSave(),
              ))
        ],
      ),
    );
  }
}

class _MovieName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: model?.title,
                style: BaseTextStyle.baseTitleText(Colors.white)),
            TextSpan(
              text: " (${model?.releaseDate?.year})",
              style: BaseTextStyle.baseTitleText(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class _MovieInfo extends StatelessWidget {
  const _MovieInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          model?.allInfo,
          textAlign: TextAlign.center,
          maxLines: 3,
          style: BaseTextStyle.baseSimilarText(Colors.white),
        ),
      ),
    );
  }
}
