abstract class AuthenticationEvent {}

class AuthenticationUserChanged extends AuthenticationEvent {
  AuthenticationUserChanged(this.user);

  final dynamic user;
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}