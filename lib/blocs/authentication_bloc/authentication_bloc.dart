import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final UserRepository userRepository;
//   AuthenticationBloc({@required this.userRepository})
//       : assert(userRepository != null);
//   @override
//   AuthenticationState get initialState => AuthenticationUninitialisedState();

//   @override
//   Stream<AuthenticationState> mapEventToState(
//       AuthenticationEvent event) async* {
//     if (event is AppStartedEvent) {
//       final bool hasToken = await userRepository.hasToken();
//       if (hasToken) {
//         SharedPreferences preferences = await SharedPreferences.getInstance();
//         yield AuthenticationAuthenticatedState(
//           address: preferences.getString('address'),
//           email: preferences.getString('email'),
//           imageUrl: preferences.getString('imageUrl'),
//           name: preferences.getString('name'),
//           token: preferences.getString('token'),
//         );
//       } else {
//         yield AuthenticationUnauthenticatedState();
//       }
//     }
//     if (event is LoggedInEvent) {
//       yield AuthenticationLoadingState();
//       await userRepository.persistToken(
//           imageUrl: event.imageUrl,
//           name: event.name,
//           token: event.token,
//           email: event.email,
//           address: event.address);
//       yield AuthenticationAuthenticatedState(
//           imageUrl: event.imageUrl,
//           name: event.name,
//           email: event.email,
//           token: event.token,
//           address: event.address);
//     }
//     if (event is LoggedOutEvent) {
//       yield AuthenticationLoadingState();
//       await userRepository.deleteToken();
//       yield AuthenticationUnauthenticatedState();
//     }
//   }
// }



class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({
	  required UserRepository myUserRepository}) 
    : userRepository = myUserRepository,       //access default state
		  super(const AuthenticationState.unknown()) {
		    _userSubscription = userRepository.user.listen((authUser) {
			    add(AuthenticationUserChanged(authUser));   //trigger new event every time user getter changes
			});   
      on<AuthenticationUserChanged>((event, emit) {
			  if(event.user != null) {
				  emit(AuthenticationState.authenticated(event.user!));
			  } else {
				  emit(const AuthenticationState.unauthenticated());
			  }
      });
  }   
  @override
	Future<void> close() {
		_userSubscription.cancel();  //cancel everytime close bloc
		return super.close();
	}
}