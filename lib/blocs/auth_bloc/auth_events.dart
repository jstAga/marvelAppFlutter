abstract class AuthEvents {}

class AuthCheckStatusEvent extends AuthEvents {}

class AuthLoginEvent extends AuthEvents {
  final String login;
  final String password;

  AuthLoginEvent({required this.login, required this.password});
}

class AuthLogoutEvent extends AuthEvents {}
