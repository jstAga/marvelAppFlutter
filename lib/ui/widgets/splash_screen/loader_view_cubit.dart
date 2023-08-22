import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_bloc.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_events.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_state.dart';

enum LoaderViewCubitState { authorized, notAuthorized, unknown }

class LoaderViewCubit extends Cubit<LoaderViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  LoaderViewCubit(
    this.authBloc,
    LoaderViewCubitState initialState,
  ) : super(initialState) {
    // if (authBloc.state is AuthAuthorizedState) {
    //   emit(LoaderViewCubitState.authorized);
    // } else {
    Future.microtask(() {
      authBloc.add(AuthCheckStatusEvent());
      _onState(authBloc.state);
      authBlocSubscription = authBloc.stream.listen(_onState);
    });

    // }
  }

  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderViewCubitState.authorized);
    } else if (state is AuthUnauthorizedState) {
      emit(LoaderViewCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
