import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   final UserRepository userRepository;
//   final AuthenticationBloc authenticationBloc;
//   RegisterBloc({@required this.authenticationBloc, @required this.userRepository})
//       : assert(authenticationBloc != null),
//         assert(userRepository != null);
//   @override
//   RegisterState get initialState => RegisterInitialState();

//   @override
//   Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
//     if (event is RegisterButtonPressedEvent) {
//       yield RegisterLoadingState();
//       try {
//         final user = await userRepository.register(
//             email: event.email, password: event.password, name: event.name);
//            authenticationBloc.add(LoggedInEvent(
//           token: user.token,
//           name: user.name,
//           imageUrl: user.imageUrl,
//           email: user.email,
//           address: user.address,
//         ));
//         yield RegisterInitialState();
//       } catch (e) {
//         yield RegisterFailureState(error: e.toString());
//       }
//     } else if (event is UpdateProfileEvent) {
//       yield RegisterLoadingState();
//       try {
//         final message =
//             await profileRepository.updateProfile(updateUser: event.user);
//         yield RegisterSuccessState(message: message);
//       } catch (e) {
//         yield RegisterFailureState(error: e.toString());
//       }
//     }
//   }
// }



class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({
    required UserRepository userRepository
  }) : _userRepository = userRepository,
    super(RegisterInitial()) {
    on<RegisterRequired>((event, emit) async {
      emit(RegisterProcess());
      try {
				MyUserModel user = await _userRepository.register(event.user, event.password);
				await _userRepository.setUserData(user);  //set data in firestore
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterFailure());
      }
    });
  }
}
