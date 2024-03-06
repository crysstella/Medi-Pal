import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medipal/main_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  Bloc.observer = MainBlocObserver();
  runApp(MyApp(FirebaseUserRepository(),));  
}