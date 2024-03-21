part of 'register_bloc.dart';
// abstract class RegisterState extends Equatable {}

// class RegisterInitialState extends RegisterState {
//   @override
//   String toString() => 'RegisterInitial';

//   @override
//   List<Object> get props => null;
// }

// class RegisterLoadingState extends RegisterState {
//   @override
//   String toString() => 'RegisterLoading';

//   @override
//   List<Object> get props => null;
// }

// class RegisterFailureState extends RegisterState {
//   final String error;

//   RegisterFailureState({@required this.error});

//   @override
//   String toString() => 'RegisterFailure { error: $error }';

//   @override
//   List<Object> get props => [error];
// }

// class RegisterSuccessState extends RegisterState {
//   final String message;

//   RegisterSuccessState({@required this.message});

//   @override
//   List<Object> get props => [message];
// }


abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}
class RegisterFailure extends RegisterState {}
class RegisterProcess extends RegisterState {}