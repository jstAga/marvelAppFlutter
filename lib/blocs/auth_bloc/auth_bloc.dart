import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:get_it/get_it.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_events.dart';
import 'package:marvel_app_flutter/blocs/auth_bloc/auth_state.dart';
import 'package:marvel_app_flutter/data/local/data_provider/session_data_provider.dart';
import 'package:marvel_app_flutter/data/remote/api_client/account_api_client.dart';
import 'package:marvel_app_flutter/data/remote/api_client/auth_api_client.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final _authApiClient = GetIt.instance<AuthApiClient>();
  final _accountApiClient = GetIt.instance<AccountApiClient>();
  final _sessionDataProvider = GetIt.instance<SessionDataProvider>();

  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthEvents>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        await _onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await _onAuthLoginEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await _onAuthLogoutEvent(event, emit);
      }
    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }

  Future<void> _onAuthCheckStatusEvent(
      AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProgressState());
    final sessionId = await _sessionDataProvider.getSessionId();
    final newState =
        sessionId != null ? AuthAuthorizedState() : AuthUnauthorizedState();
    emit(newState);
  }

  Future<void> _onAuthLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgressState());
      final sessionId = await _authApiClient.auth(
          username: event.login, password: event.password);
      final accountId = await _accountApiClient.getAccountInfo(sessionId);
      await _sessionDataProvider.setSessionId(sessionId);
      await _sessionDataProvider.setAccountId(accountId);
      emit(AuthAuthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  Future<void> _onAuthLogoutEvent(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _sessionDataProvider.deleteSessionId();
      await _sessionDataProvider.deleteSessionId();
      emit(AuthUnauthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
}
