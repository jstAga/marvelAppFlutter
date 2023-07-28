import 'package:flutter/cupertino.dart';
import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';

class AppViewModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);
    await Navigator.pushNamedAndRemoveUntil(
        context, MainNavigationRoutesNames.authMovieDb, (route) => false);
  }
}
