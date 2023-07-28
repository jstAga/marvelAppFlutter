import 'dart:convert';
import 'dart:io';

import 'package:marvel_app_flutter/data/core/network/api_client_exception.dart';
import 'package:marvel_app_flutter/data/core/network/network_ext.dart';


class BaseApiClient {
  BaseApiClient(
      {required this.host, required this.client, required this.apiKey});

  final String host;
  final HttpClient client;
  final String apiKey;

  Uri _makeUri(String host, String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse("$host$path");
    return parameters == null ? uri : uri.replace(queryParameters: parameters);
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json["status_code"];
      final code = status is int ? status : 0; // int to string
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      } else if (code == 3) {
        throw ApiClientException(ApiClientExceptionType.sessionExpired);
      } else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }

  Future<T> get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(host, path, parameters);
    try {
      final request = await client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());

      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> post<T>(String path, T Function(dynamic json) parser,
      Map<String, dynamic> bodyParameters,
      [Map<String, dynamic>? urlParameters]) async {
    final url = _makeUri(host, path, urlParameters);
    try {
      final request = await client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final json = (await response.jsonDecode()) as dynamic;

      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}
