part of 'authentication_bloc.dart';

// abstract class AuthenticationEvent extends Equatable {}

// class AppStartedEvent extends AuthenticationEvent {
//   @override
//   String toString() => 'AppStarted';

//   @override
//   List<Object> get props => null;
// }

// class LoggedInEvent extends AuthenticationEvent {
//   final String token;
//   final String name;
//   final String imageUrl;
//   final String email;
//   final String address;

//   LoggedInEvent(
//       {@required this.token,
//       @required this.name,
//       this.imageUrl,
//       this.address,
//       @required this.email});

//   @override
//   String toString() => 'LoggedIn { token: $token }';

//   @override
//   List<Object> get props => [token, name, imageUrl, address, email];
// }

// class LoggedOutEvent extends AuthenticationEvent {
//   @override
//   String toString() => 'LoggedOut';

//   @override
//   List<Object> get props => null;
// }



@immutable
abstract class AuthenticationEvent extends Equatable {

  //empty constructor
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User? user;
}