// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:user_repository/user_repository.dart';

// part 'update_my_user_event.dart';
// part 'update_my_user_state.dart';

// class UpdateMyUserBloc extends Bloc<UpdateMyUserEvent, UpdateMyUserState> {
//   final UserRepository _userRepository;

//   UpdateMyUserBloc({required this._userRepository}) : super(UpdateMyUserInitial()) {
//     on(<UpdateButtonPressed>(event, emit) async {
//       emit(UpdateLoading());
//       try {
//         final customer =
//             await userRepository.updateName(event.idCus, event.newName);
//         if (customer != null) {
//           print('name thanh cong');
//           emit(UpdateNameSuccess(customer: customer));
//         } else {
//           print('name that bai');
//           emit(UpdateNameFailure(error: 'Cập nhật Name không thành công!'));
//         }
//       } catch (e) {
//         print(e.toString());
//         emit(UpdateNameFailure(error: e.toString()));
//       }
//     });
//   }
// }
