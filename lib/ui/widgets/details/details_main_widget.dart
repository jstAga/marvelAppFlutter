import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/ui/constants/bases/bases_ext.dart';
import 'package:marvel_app_flutter/ui/entity/movie_details/movie_details_ui.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_view_model.dart';
import 'package:provider/provider.dart';

class DetailsMainWidget extends StatelessWidget {
  const DetailsMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const _TopPoster(),
      Padding(padding: const EdgeInsets.all(20), child: _MovieTitle()),
      const _Score(),
      const _MovieInfo(),
      const _Overview(),
      const _Description(),
      const _CrewInfo(),
    ]);
  }
}

class _Score extends StatelessWidget {
  const _Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scoreData =
        context.select((DetailsViewModel vm) => vm.data.scoreData);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Text("${scoreData.voteAverage} / 10 User Score",
                style: BaseTextStyle.baseSimilarBoldText(Colors.lightBlue))),
        Container(width: 1, height: 15, color: Colors.white),
        scoreData.trailerKey != null
            ? TextButton(
                onPressed: () => Navigator.pushNamed(
                    context, MainNavigationRoutesNames.movieTrailer,
                    arguments: scoreData.trailerKey),
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
    final List<List<CrewUi>> crewChunks =
        context.select((DetailsViewModel vm) => vm.data.crewData);

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

  final List<CrewUi> crewList;

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

  final CrewUi crew;

  @override
  Widget build(BuildContext context) {
    const jobStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(crew.name, style: BaseTextStyle.baseSimilarText(Colors.white)),
          Text(crew.job, style: jobStyle),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    final overview = context.select((DetailsViewModel vm) => vm.data.overview);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(overview, style: BaseTextStyle.baseSimilarText(Colors.white)),
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
  const _TopPoster();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DetailsViewModel>();
    final posterData =
        context.select((DetailsViewModel vm) => vm.data.posterData);
    final backdropPath = posterData.backdropPath;
    final posterPath = posterData.posterPath;
    final favoriteIcon = context
        .select((DetailsViewModel vm) => vm.data.posterData.favoriteIcon);

    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          if (backdropPath != null)
            Image.network(backdropPath,
                width: double.infinity, fit: BoxFit.fitWidth),
          if (posterPath != null)
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
                icon: favoriteIcon,
                onPressed: () => viewModel.toggleSave(context),
              ))
        ],
      ),
    );
  }
}

class _MovieTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleData =
        context.select((DetailsViewModel vm) => vm.data.titleData);
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: titleData.title,
                style: BaseTextStyle.baseTitleText(Colors.white)),
            TextSpan(
              text: " (${titleData.year})",
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
    final allInfo = context.select((DetailsViewModel vm) => vm.data.allInfo);
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          allInfo,
          textAlign: TextAlign.center,
          maxLines: 3,
          style: BaseTextStyle.baseSimilarText(Colors.white),
        ),
      ),
    );
  }
}
