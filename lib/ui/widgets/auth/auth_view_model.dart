import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:marvel_app_flutter/data/core/network/api_client_exception.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;
  bool _isAuthInProgress = false;

  bool get canStartAuth => !_isAuthInProgress;

  bool get isAuthInProgress => _isAuthInProgress;

  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;

    if (username.isEmpty || password.isEmpty) {
      _updateErrorState("Username or password is empty", false);
      return;
    }
    _updateErrorState(null, true);

    _errorMessage = await _tryLogin(username, password);
    if (_errorMessage == null) {
      MainNavigation.resetNavigation(context);
    } else {
      _updateErrorState(_errorMessage, false);
    }
  }

  Future<String?> _tryLogin(String username, String password) async {
    try {
      await _authRepository.login(username, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return "Server is not available. Check internet connection";
        case ApiClientExceptionType.sessionExpired:
          return "Session is expired try again";
        case ApiClientExceptionType.auth:
          return "Username or password is incorrect";
        case ApiClientExceptionType.other:
          return "Unknown error try again";
      }
    } catch (e) {
      return "Unknown error try again";
    }
    return null;
  }

  void _updateErrorState(String? errorMessage, bool isAuthInProgress) {
    if (_errorMessage == errorMessage &&
        _isAuthInProgress == isAuthInProgress) {
      return;
    } else {
      _errorMessage = errorMessage;
      _isAuthInProgress = isAuthInProgress;
      notifyListeners();
    }
  }
}
