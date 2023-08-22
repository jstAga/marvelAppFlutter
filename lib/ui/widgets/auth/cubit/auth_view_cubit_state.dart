abstract class AuthViewCubitState {}

class AuthViwCubitFormInProgressState extends AuthViewCubitState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthViwCubitFormInProgressState &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViwCubitErrorState extends AuthViewCubitState {
  final String? errorMessage;

  AuthViwCubitErrorState(this.errorMessage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthViwCubitErrorState &&
          runtimeType == other.runtimeType &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => errorMessage.hashCode;
}

class AuthViwCubitSuccessState extends AuthViewCubitState {

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthViwCubitSuccessState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViwCubitProgressState extends AuthViewCubitState {

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthViwCubitProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
