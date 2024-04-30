//functions
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/my_user_model.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepository implements UserRepository {

  FirebaseUserRepository({ FirebaseAuth? firebaseAuth}) 
  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('registered users');

  //stream of [MyUser] emits the current user when the authentication state changes
  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
		  final currentUser = firebaseUser;
		  return currentUser;
	  });
  }

  //implement register
  @override
  Future<MyUserModel> register(MyUserModel myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
			  email: myUser.email,
			  password: password
		  );
		  myUser = myUser.copyWith(
        email: user.user!.email
			  //id: user.user!.uid
		  );
		return myUser;
    } catch (e) {
      log(e.toString());
		  rethrow;
    }
  }

  //implement log in
  @override
  Future<void> logIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
			  email: email,
			  password: password
		  );
    } catch (e) {
      log(e.toString());
		  rethrow;
    }
  }
  //implement log out
  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch(e) {
      log(e.toString());
			rethrow;
    }
  }
  //implement reset password
  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch(e) {
      log(e.toString());
			rethrow;
    }
  }

  //transform myusermodel obj to myuserentity to string obj 
  @override
  Future<void> setUserData(MyUserModel user) async {
    try {
      await usersCollection.doc(user.email).set(user.toEntity().toDocument());
    } catch(e) {
      log(e.toString());
			rethrow;
    }
  }
  // @override
  // Future<void> updateUserData(MyUserModel user, MealModel meal) async {
  //   final userDocRef =
  //       _firebaseFirestore.collection('favouritemeals').doc(user);

  //   return _firebaseFirestore.runTransaction((transaction) async {
  //     final snapshot = await transaction.get(userDocRef);

  //     if (snapshot.exists) {
  //       final currentFavoriteMeals = List.from(snapshot.get('meals') ?? []);
  //       if (!currentFavoriteMeals.contains(meal.id)) {
  //         currentFavoriteMeals.add(meal.id);
  //       }

  //       transaction.update(userDocRef, {'meals': currentFavoriteMeals});
  //     } else {
  //       transaction.set(userDocRef, {
  //         'meals': [meal.id]
  //       });
  //     }
  //   });
  // }
  //implement getMyUser: get user id and doc and return my user from entity using val from map 
  @override
  Future<MyUserModel> getMyUser(String myUserEmail) async {
    try {
      return usersCollection.doc(myUserEmail).get().then((value) =>
				MyUserModel.fromEntity(MyUserEntity.fromDocument(value.data()!))
			);
    } catch(e) {
      log(e.toString());
			rethrow;
    }
  }

  @override
  Future<bool> isLoggedIn() async{
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }
  
}

