import 'dart:io';

import 'package:marvel_app_flutter/data/core/network/base_api_client.dart';
import 'package:marvel_app_flutter/data/remote/movie_db_constants.dart';


class AuthApiClient {
  final _baseApiClient = BaseApiClient(
      host: MovieDbConstants.baseUrl,
      client: HttpClient(),
      apiKey: MovieDbConstants.apiKey);

  Future<String> auth(
      {required String username, required String password}) async {
    final token = await _getToken();
    final validateToken = await _postValidateUser(
        username: username, password: password, requestToken: token);
    final sessionId = await _postSession(validateToken);
    return sessionId;
  }

  Future<String> _getToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final result = _baseApiClient.get(MovieDbConstants.getToken, parser,
        <String, dynamic>{"api_key": MovieDbConstants.apiKey});

    return result;
  }

  Future<String> _postValidateUser(
      {required String username,
      required String password,
      required String requestToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final result = _baseApiClient.post(
        MovieDbConstants.postValidateUser, parser, <String, dynamic>{
      "username": username,
      "password": password,
      "request_token": requestToken
    }, <String, dynamic>{
      "api_key": MovieDbConstants.apiKey
    });
    return result;
  }

  Future<String> _postSession(String requestToken) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap["session_id"] as String;
      return sessionId;
    }

    final result = _baseApiClient.post(
        MovieDbConstants.postSession,
        parser,
        <String, dynamic>{"request_token": requestToken},
        <String, dynamic>{"api_key": MovieDbConstants.apiKey});
    return result;
  }

  int _getAccountInfo(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    final result = jsonMap["id"] as int;
    return result;
  }

  Future<int> getAccountInfo(String sessionId) {
    final result = _baseApiClient
        .get(MovieDbConstants.accountInfo, _getAccountInfo, <String, dynamic>{
      "api_key": MovieDbConstants.apiKey,
      "session_id": sessionId,
    });
    return result;
  }
}
