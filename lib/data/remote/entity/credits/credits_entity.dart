import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app_flutter/data/remote/movie_db_constants.dart';

part 'credits_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CreditsEntity {
  final List<Cast> cast;
  final List<Crew> crew;

  CreditsEntity({required this.cast, required this.crew});

  factory CreditsEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsEntityToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  Cast(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.castId,
      required this.character,
      required this.creditId,
      required this.order});

  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);

  get profileImage => MovieDbConstants.baseImage + (profilePath ?? "");

}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final String? creditId;
  final String? department;
  final String? job;

  Crew(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.creditId,
      required this.department,
      required this.job});

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);

}
