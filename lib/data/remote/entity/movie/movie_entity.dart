import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app_flutter/data/remote/entity/data_ext.dart';
import 'package:marvel_app_flutter/data/core/network/configurations.dart';

part 'movie_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieEntity {
  MovieEntity({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.videoCount,
    required this.video,
    required this.voteAverage,
  });

  final bool? adult;
  final String? backdropPath;
  List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? videoCount;

  get image => Configurations.baseImage + (posterPath ?? "");

  factory MovieEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);
}
