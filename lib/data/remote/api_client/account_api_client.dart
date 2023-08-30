import 'dart:io';

import 'package:marvel_app_flutter/data/core/network/base_api_client.dart';
import 'package:marvel_app_flutter/data/core/network/configurations.dart';

class AccountApiClient{
  final _apiClient = BaseApiClient(
      host: Configurations.baseUrl,
      client: HttpClient(),
      apiKey: Configurations.apiKey);

  int _getAccountInfo(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    final result = jsonMap["id"] as int;
    return result;
  }

  Future<int> getAccountInfo(String sessionId) {
    final result = _apiClient
        .get(Configurations.accountInfo, _getAccountInfo, <String, dynamic>{
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

    final result = _apiClient.post(
        "/account/$accountId/favorite?", parser, <String, dynamic>{
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