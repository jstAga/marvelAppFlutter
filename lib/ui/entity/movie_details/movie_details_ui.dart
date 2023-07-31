import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/data/remote/entity/credits/credits_entity.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_details/movie_details.dart';

class MovieDetailsUi {
  String title = "";
  bool isLoading = true;
  String overview = "";
  MovieDetailsPosterUi posterData = MovieDetailsPosterUi(
      favoriteIcon: const Icon(
    Icons.bookmark_add,
    color: Colors.white,
  ));
  MovieDetailsTitleUi titleData = MovieDetailsTitleUi(
    title: "",
    year: "",
  );
  MovieDetailsScoreUi scoreData = MovieDetailsScoreUi(voteAverage: 0);
  String allInfo = "";
  List<List<CrewUi>> crewData = [];
  List<CastUi> castData = [];

  MovieDetailsUi();

  MovieDetailsUi.toUiFromEntity(MovieDetailsEntity? details, bool isMovieSaved)
      : title = details?.title ?? "Loading...",
        isLoading = details == null,
        overview = details?.overview ?? "",
        posterData = MovieDetailsPosterUi(
            backdropPath: details?.backdrop ?? "",
            posterPath: details?.poster ?? "",
            favoriteIcon: isMovieSaved
                ? const Icon(Icons.bookmark_add, color: Colors.white)
                : const Icon(Icons.bookmark, color: Colors.yellow)),
        titleData = MovieDetailsTitleUi(
            title: details?.title ?? "",
            year: details?.releaseDate?.year.toString() ?? ""),
        allInfo = details?.allInfo ?? "Unknown",
        scoreData = MovieDetailsScoreUi._makeScoreData(details),
        crewData = details?.crewChunks ?? [],
        castData = CastUi.makeCastData(details);
}

class MovieDetailsPosterUi {
  final String? posterPath;
  final String? backdropPath;
  final Icon favoriteIcon;

  MovieDetailsPosterUi({
    this.posterPath,
    this.backdropPath,
    required this.favoriteIcon,
  });
}

class MovieDetailsTitleUi {
  final String title;
  final String year;

  MovieDetailsTitleUi({required this.title, required this.year});
}

class MovieDetailsScoreUi {
  final num? voteAverage;
  final String? trailerKey;

  MovieDetailsScoreUi({this.voteAverage, this.trailerKey});

  static MovieDetailsScoreUi _makeScoreData(MovieDetailsEntity? details) {
    final num voteAverage;
    if (details?.voteAverage != null && details != null) {
      voteAverage = ((details.voteAverage! * 10).round() / 10);
    } else {
      voteAverage = 0;
    }
    final videos = details?.videos?.results
        .where((video) => video.type == "Trailer" && video.site == "YouTube");
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return MovieDetailsScoreUi(
      voteAverage: voteAverage,
      trailerKey: trailerKey,
    );
  }
}

class CrewUi {
  final String name;
  final String job;

  CrewUi({required this.name, required this.job});
}

class CastUi {
  final String? character;
  final String? name;
  final String profileImage;

  CastUi({this.character, this.name, required this.profileImage});

  CastUi.fromCrewResponse(Cast? cast)
      : name = cast?.name ?? "Unknown",
        character = cast?.character ?? "Unknown",
        profileImage = cast?.profileImage;

  static List<CastUi> makeCastData(MovieDetailsEntity? details) {
    if (details != null && details.credits != null) {
      return (details.credits?.cast.map((e) => CastUi.fromCrewResponse(e)))!
          .toList();
    } else {
      return [];
    }
  }
}
