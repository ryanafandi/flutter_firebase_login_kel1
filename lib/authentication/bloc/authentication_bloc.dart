import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../repository/authentication_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository,
       super(const AuthenticationState(status: AuthenticationStatus.unknown)) {
    on<AuthenticationUserChanged>(_onUserChanged);

    on<AuthenticationLogoutRequested>(_onLogoutRequested);

    _userSubscription = _authenticationRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;

  late final StreamSubscription<dynamic> _userSubscription;

  void _onUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    if (event.user != null) {
      emit(
        AuthenticationState(
          status: AuthenticationStatus.authenticated,

          user: event.user,
        ),
      );
    } else {
      emit(
        const AuthenticationState(
          status: AuthenticationStatus.unauthenticated,

          user: null,
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationRepository.signOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();

    return super.close();
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    final status = json['status'];

    return AuthenticationState(status: AuthenticationStatus.values[status]);
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return {'status': state.status.index};
  }
}