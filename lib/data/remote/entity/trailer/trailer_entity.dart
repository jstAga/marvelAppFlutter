import 'package:json_annotation/json_annotation.dart';

part 'trailer_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TrailerResponse {
  TrailerResponse({
    required this.results,
  });

  final List<TrailerEntity> results;

  factory TrailerResponse.fromJson(Map<String, dynamic> json) =>
      _$TrailerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TrailerEntity {
  TrailerEntity({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  @JsonKey(name: "iso_639_1")
  final String iso6391;
  @JsonKey(name: "iso_3166_1")
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  factory TrailerEntity.fromJson(Map<String, dynamic> json) =>
      _$TrailerEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerEntityToJson(this);
}
