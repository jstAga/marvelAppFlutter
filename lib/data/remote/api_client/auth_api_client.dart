import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:marvel_app_flutter/data/core/network/base_api_client.dart';
import 'package:marvel_app_flutter/data/core/network/configurations.dart';


class AuthApiClient {
  final _apiClient = GetIt.instance<BaseApiClient>();

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

    final result = _apiClient.get(Configurations.getToken, parser,
        <String, dynamic>{"api_key": Configurations.apiKey});

    return result;
  }

  Future<String> _postValidateUser({required String username,
    required String password,
    required String requestToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final result = _apiClient.post(
        Configurations.postValidateUser, parser, <String, dynamic>{
      "username": username,
      "password": password,
      "request_token": requestToken
    }, <String, dynamic>{
      "api_key": Configurations.apiKey
    });
    return result;
  }

  Future<String> _postSession(String requestToken) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap["session_id"] as String;
      return sessionId;
    }

    final result = _apiClient.post(
        Configurations.postSession,
        parser,
        <String, dynamic>{"request_token": requestToken},
        <String, dynamic>{"api_key": Configurations.apiKey});
    return result;
  }
}