import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'components/start/start/launch.dart';
import 'firebase_options.dart';

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
        colorSchemeSeed: const Color(0x9EA0A1FA),
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: LaunchScreen(),
    );
  }
}