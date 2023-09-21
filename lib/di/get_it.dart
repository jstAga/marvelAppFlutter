import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:marvel_app_flutter/data/core/network/base_api_client.dart';
import 'package:marvel_app_flutter/data/core/network/configurations.dart';
import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';
import 'package:marvel_app_flutter/data/remote/api_client/account_api_client.dart';
import 'package:marvel_app_flutter/data/remote/api_client/auth_api_client.dart';
import 'package:marvel_app_flutter/data/remote/api_client/movies_api_client.dart';

void setupDependencies() {
  setupLocalStorage();
  setupApiClients();
}

void setupApiClients() {
  GetIt.instance.registerSingleton<BaseApiClient>(
    BaseApiClient(
        host: Configurations.baseUrl,
        client: HttpClient(),
        apiKey: Configurations.apiKey),
  );
  GetIt.instance.registerSingleton<AccountApiClient>(AccountApiClient());
  GetIt.instance.registerSingleton<MoviesApiClient>(MoviesApiClient());
  GetIt.instance.registerSingleton<AuthApiClient>(AuthApiClient());
}

void setupLocalStorage() {
  GetIt.instance
      .registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  GetIt.instance.registerSingleton<SessionDataProvider>(SessionDataProvider());
}
