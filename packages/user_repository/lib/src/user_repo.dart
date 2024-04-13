//methods for user repository
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

abstract class UserRepository {

	Stream<User?> get user;
  
  Future<MyUserModel> register(MyUserModel myUser, String password);
	
	Future<void> logIn(String email, String password);

	Future<void> logOut();

	Future<void> resetPassword(String email);

	Future<void> setUserData(MyUserModel user);

	Future<MyUserModel> getMyUser(String myUserEmail);

  Future<bool> isLoggedIn();

}