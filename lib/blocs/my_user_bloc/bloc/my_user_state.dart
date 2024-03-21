part of 'my_user_bloc.dart';

enum MyUserStatus { loading, success, failure} 

class MyUserState extends Equatable {

  final MyUserStatus status;
  final MyUserModel? user;

  //empty constructor 
  const MyUserState._({
    this.status = MyUserStatus.loading,
    this.user,
  });

  //loading state 
  const MyUserState.loading() : this._();
  //success
  const MyUserState.success(MyUserModel user) : this._(status: MyUserStatus.success, user: user);
  //failure
  const MyUserState.failure() : this._(status: MyUserStatus.failure);
  
  @override
  List<Object?> get props => [status, user];
}

