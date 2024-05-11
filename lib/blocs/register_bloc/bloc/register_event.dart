part of 'register_bloc.dart';

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