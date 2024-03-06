part of 'authentication_bloc.dart';

// abstract class AuthenticationState extends Equatable {}

// class AuthenticationUninitialisedState extends AuthenticationState {
//   @override
//   String toString() {
//     return "AuthenticationUninitialisedState";
//   }

//   @override
//   List<Object> get props => null;
// }

// class AuthenticationAuthenticatedState extends AuthenticationState {
//   final String name;
//   final String email;
//   final String address;
//   final String imageUrl;
//   final String token;
//   AuthenticationAuthenticatedState(
//       {@required this.name,
//       @required this.email,
//       @required this.address,
//       @required this.token,
//       @required this.imageUrl});

//   @override
//   List<Object> get props => [
//         name,
//         email,
//         address,
//         imageUrl,
//         token,
//       ];
// }

// class AuthenticationUnauthenticatedState extends AuthenticationState {
//   @override
//   String toString() => 'AuthenticationUnauthenticated';
//   List<Object> get props => null;
// }

// class AuthenticationLoadingState extends AuthenticationState {
//   @override
//   String toString() => 'AuthenticationLoading';
//   List<Object> get props => null;
// }



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
