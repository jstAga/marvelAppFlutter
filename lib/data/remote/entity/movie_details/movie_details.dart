import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app_flutter/data/remote/entity/credits/credits_entity.dart';
import 'package:marvel_app_flutter/data/remote/entity/data_ext.dart';
import 'package:marvel_app_flutter/data/remote/entity/trailer/trailer_entity.dart';
import 'package:marvel_app_flutter/data/core/network/configurations.dart';
import 'package:marvel_app_flutter/ui/entity/movie_details/movie_details_ui.dart';

part 'movie_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsEntity {
  MovieDetailsEntity(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.credits,
      this.videos});

  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final num? budget;
  final List<Genres>? genres;
  final String? homepage;
  final num? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final num? revenue;
  final num? runtime;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final num? voteAverage;
  final num? voteCount;
  final CreditsEntity? credits;
  final TrailerResponse? videos;

  get allInfo {
    return "($_allCountries) $_duration, $_allGenres";
  }

  get _duration {
    if (runtime != null) {
      final duration = Duration(minutes: runtime!.toInt());
      return "${duration.inHours}h ${duration.inMinutes.remainder(60)}min";
    }
  }

  String get _allGenres {
    String result = "";
    if (genres == null) result = "No genres";

    for (int i = 0; i < genres!.length; i++) {
      if (genres!.length - 1 != i) {
        result += "${genres![i].name}, ";
      } else {
        result += "${genres![i].name}";
      }
    }
    return result;
  }

  List<List<CrewUi>> get crewChunks {
    var crew = credits?.crew
        .map((e) => CrewUi(name: e.name ?? "Unknown", job: e.job ?? "Unknown"))
        .toList();
    if (crew == null) return [];
    crew = crew.length > 4 ? crew.sublist(0, 3) : crew;
    var crewChunks = <List<CrewUi>>[];
    for (var i = 0; i < crew.length; i++) {
      crewChunks
          .add(crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }
    return crewChunks;
  }

  get _allCountries {
    String result = "";
    if (productionCountries == null) result = "No countries";

    for (int i = 0; i < productionCountries!.length; i++) {
      if (productionCountries!.length - 1 != i) {
        result += "${productionCountries![i].iso}, ";
      } else {
        result += "${productionCountries![i].iso}";
      }
    }
    return result;
  }

  factory MovieDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsEntityToJson(this);

  get poster => Configurations.baseImage + (posterPath ?? "");

  get backdrop => Configurations.baseImage + (backdropPath ?? "");
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BelongsToCollection {
  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  final num? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Genres {
  Genres({
    this.id,
    this.name,
  });

  final num? id;
  final String? name;

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProductionCompanies {
  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  num? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SpokenLanguages {
  SpokenLanguages({
    this.englishName,
    this.iso,
    this.name,
  });

  final String? englishName;
  @JsonKey(name: "iso_639_1")
  final String? iso;
  final String? name;

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguagesFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProductionCountries {
  ProductionCountries({
    this.iso,
    this.name,
  });

  @JsonKey(name: "iso_3166_1")
  final String? iso;
  final String? name;

  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);
}
