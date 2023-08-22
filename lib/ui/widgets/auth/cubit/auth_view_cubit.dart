import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_bloc.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_events.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_state.dart';
import 'package:marvel_app_flutter/data/core/network/api_client_exception.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/cubit/auth_view_cubit_state.dart';

class AuthViewCubit extends Cubit<AuthViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  AuthViewCubit(AuthViewCubitState initialState, this.authBloc)
      : super(initialState) {
    _onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(_onState);
  }

  bool _isValid(String login, String password) {
    return login.isNotEmpty && password.isNotEmpty;
  }

  String _mapErrorToMessage(Object error) {
    if (error is ApiClientException) {
      switch (error.type) {
        case ApiClientExceptionType.network:
          return "Server is not available. Check internet connection";
        case ApiClientExceptionType.sessionExpired:
          return "Session is expired try again";
        case ApiClientExceptionType.auth:
          return "Username or password is incorrect";
        case ApiClientExceptionType.other:
          return "Unknown error try again";
      }
    } else {
      return "Unknown error try again";
    }
  }

  void auth({required String login, required String password}) {
    if (!_isValid(login, password)) {
      final state = AuthViwCubitErrorState("Username or password is empty");
      emit(state);
      return;
    }
    authBloc.add(AuthLoginEvent(login: login, password: password));
  }

  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      authBlocSubscription.cancel();
      emit(AuthViwCubitSuccessState());
    } else if (state is AuthUnauthorizedState) {
      emit(AuthViwCubitFormInProgressState());
    } else if (state is AuthFailureState) {
      emit(AuthViwCubitErrorState(_mapErrorToMessage(state.error)));
    } else if (state is AuthInProgressState) {
      emit(AuthViwCubitProgressState());
    } else if (state is AuthCheckInProgressState) {
      emit(AuthViwCubitProgressState());
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
