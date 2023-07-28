import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';

class AuthRepository {
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }
}
