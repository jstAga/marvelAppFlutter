import 'dart:io';

import 'package:marvel_app_flutter/data/core/network/base_api_client.dart';
import 'package:marvel_app_flutter/data/remote/entity/detail_movie/movie_details.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_response/movie_response.dart';
import 'package:marvel_app_flutter/data/core/network/configurations.dart';


class MoviesApiClient {
  final _apiClient = BaseApiClient(
      host: Configurations.baseUrl,
      client: HttpClient(),
      apiKey: Configurations.apiKey);

  MovieResponse _movieResponseParser(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    final response = MovieResponse.fromJson(jsonMap);
    return response;
  }

  Future<MovieResponse> getMovies(int page, String language) async {
    final result = _apiClient.get(
        Configurations.getMovies, _movieResponseParser, <String, dynamic>{
      "api_key": Configurations.apiKey,
      "page": page.toString(),
      "language": language,
    });
    return result;
  }

  Future<MovieResponse> searchMovies(String query, int page, String language) {
    final result = _apiClient.get(
        Configurations.searchMovie, _movieResponseParser, <String, dynamic>{
      "api_key": Configurations.apiKey,
      "query": query,
      "page": page.toString(),
      "language": language,
    });
    return result;
  }

  MovieDetailsEntity _movieDetailsParser(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    final response = MovieDetailsEntity.fromJson(jsonMap);
    return response;
  }

  Future<MovieDetailsEntity> getDetails(int movieId, String language) {
    final result = _apiClient.get(
        "${Configurations.movieDetails}$movieId?",
        _movieDetailsParser, <String, dynamic>{
      "api_key": Configurations.apiKey,
      "language": language,
      "append_to_response": "credits,videos"
    });
    return result;
  }

  bool _isMovieSavedParser(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    final result = jsonMap["favorite"] as bool;
    return result;
  }

  Future<bool> isMovieSaved(int movieId, String sessionId) {
    final result = _apiClient.get("/movie/$movieId/account_states?",
        _isMovieSavedParser, <String, dynamic>{
      "api_key": Configurations.apiKey,
      "session_id": sessionId,
    });
    return result;
  }

  Future<int> saveMovie(
      {required int accountId,
      required String sessionId,
      required MediaType mediaType,
      required int mediaId,
      required bool isSaved}) async {
    parser(dynamic json) {
      return 1;
    }

    final result = _apiClient
        .post("/account/$accountId/favorite?", parser, <String, dynamic>{
      "media_type": mediaType.asString(),
      "media_id": mediaId,
      "favorite": isSaved
    }, <String, dynamic>{
      "api_key": Configurations.apiKey,
      "session_id": sessionId
    });
    return result;
  }
}
