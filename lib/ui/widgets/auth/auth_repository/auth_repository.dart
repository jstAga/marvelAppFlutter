import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';
import 'package:marvel_app_flutter/data/remote/api_client/account_api_client.dart';
import 'package:marvel_app_flutter/data/remote/api_client/auth_api_client.dart';

class AuthRepository {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  Future<void> login(String username, String password) async {
    final sessionId = await _authApiClient.auth(username: username, password: password);
    final accountId = await _accountApiClient.getAccountInfo(sessionId);
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
  }
}
