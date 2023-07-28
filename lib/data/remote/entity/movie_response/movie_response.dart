import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie/movie_entity.dart';

part 'movie_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieResponse {
  MovieResponse(
      {required this.page,
      required this.results,
      required this.totalResults,
      required this.totalPages});

  final int page;
  final List<MovieEntity> results;
  final int? totalPages;
  final int? totalResults;

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
