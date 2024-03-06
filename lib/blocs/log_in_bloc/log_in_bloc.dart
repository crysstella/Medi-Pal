import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

// class LogInBloc extends Bloc<LogInEvent, LogInState> {
//   final UserRepository userRepository;
//   final AuthenticationBloc authenticationBloc;
//   LogInBloc({@required this.authenticationBloc, @required this.userRepository})
//       : assert(authenticationBloc != null),
//         assert(userRepository != null);
//   @override
//   LogInState get initialState => LogInInitialState();

//   @override
//   Stream<LogInState> mapEventToState(LogInEvent event) async* {
//     if (event is LogInInitialEvent) {
//       yield LogInInitialState();
//     } else if (event is LogInButtonPressedEvent) {
//       yield LogInLoadingState();
//       try {
//         final user = await userRepository.authenticate(
//             email: event.email, password: event.password);
//         authenticationBloc.add(LoggedInEvent(
//             token: user.token,
//             name: user.name,
//             imageUrl: user.imageUrl,
//             email: user.email,
//             address: user.address));
//         yield LogInInitialState();
//       } catch (e) {
//         yield LogInFailureState(error: e.toString());
//       }
//     }
//   }
// }

class LogInBloc extends Bloc<LogInEvent, LogInState> {
	final UserRepository _userRepository;
	
  LogInBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(LogInInitial()) {
    on<LogInRequired>((event, emit) async {
			emit(LogInProcess());
      try {
        await _userRepository.logIn(event.email, event.password);
				emit(LogInSuccess());    
      } catch (e) {
        log(e.toString());
				emit(const LogInFailure());
      }
    });
		on<LogOutRequired>((event, emit) async {
			await _userRepository.logOut();
    });
  }
}
