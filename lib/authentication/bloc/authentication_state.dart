enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState {
  final AuthenticationStatus status;

  final dynamic user;

  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,

    this.user,
  });

  AuthenticationState copyWith({AuthenticationStatus? status, dynamic user}) {
    return AuthenticationState(
      status: status ?? this.status,

      user: user ?? this.user,
    );
  }
}