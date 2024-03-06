part of 'register_bloc.dart';

// abstract class SignupEvent extends Equatable {}

// class SignupButtonPressedEvent extends SignupEvent {
//   final String email;
//   final String password;
//   final String name;

//   SignupButtonPressedEvent({
//     @required this.email,
//     @required this.password,
//     @required this.name,
//   });

//   @override
//   String toString() =>
//       'LoginButtonPressed { email: $email, password: $password,name:$name }';

//   @override
//   List<Object> get props => [email, password, name];
// }

// class UpdateProfileEvent extends SignupEvent {
//   final User user;
//   UpdateProfileEvent({@required this.user}) : assert(user != null);

//   @override
//   List<Object> get props => [user];
// }



@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterRequired extends RegisterEvent{
	final MyUserModel user;
	final String password;

	const RegisterRequired(this.user, this.password);
}