part of 'authentication_bloc.dart';

//status of user
enum AuthenticationStatus { authenticated, unauthenticated, unknown}

class AuthenticationState extends Equatable {

  final AuthenticationStatus status;
  final User? user;

  //empty constructor 
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  //no status known
  const AuthenticationState.unknown() : this._();

  //curr user is authenticated
  const AuthenticationState.authenticated(User user) : this._(status: AuthenticationStatus.authenticated, user: user);

  //curr user not authenticated
  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];

}
