part of 'log_in_bloc.dart';

// abstract class LogInState extends Equatable {}

// class LogInInitialState extends LogInState {
//   @override
//   String toString() => 'LogInInitial';

//   @override
//   List<Object> get props => null;
// }

// class LogInLoadingState extends LogInState {
//   @override
//   String toString() => 'LogInLoading';

//   List<Object> get props => null;
// }

// class LogInFailureState extends LogInState {
//   final String error;

//   LogInFailureState({@required this.error});

//   @override
//   String toString() => 'LogInFailure { error: $error }';

//   List<Object> get props => [error];
// }



@immutable
abstract class LogInState extends Equatable {
  const LogInState();
  
  @override
  List<Object> get props => [];
}

class LogInInitial extends LogInState {}
class LogInSuccess extends LogInState {}

class LogInFailure extends LogInState {
	final String? message;
	const LogInFailure({this.message});
}

class LogInProcess extends LogInState {}
