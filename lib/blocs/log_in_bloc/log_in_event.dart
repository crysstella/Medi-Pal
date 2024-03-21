part of 'log_in_bloc.dart';

// abstract class LogInEvent extends Equatable {}

// class LogInButtonPressedEvent extends LogInEvent {
//   final String email;
//   final String password;

//   LogInButtonPressedEvent({
//     @required this.email,
//     @required this.password,
//   });

//   @override
//   String toString() =>
//       'LogInButtonPressed { email: $email, password: $password }';

//   @override
//   List<Object> get props => [email, password];
// }

// class LogInInitialEvent extends LogInEvent {
//   @override
//   List<Object> get props => null;
// }



abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LogInRequired extends LogInEvent{
	final String email;
	final String password;

	const LogInRequired(this.email, this.password);
}

class LogOutRequired extends LogInEvent{
	const LogOutRequired();
}