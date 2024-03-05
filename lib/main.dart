import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medipal/components/start/start/startApp.dart';
import 'package:medipal/components/launch.dart';
import 'firebase/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: LaunchScreen(),
    );
  }
}