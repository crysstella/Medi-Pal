import 'package:flutter/material.dart';

class Favorite extends StatefulWidget{
  const Favorite({super.key});

  @override
  State<Favorite> createState() =>_FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Favorites')]),
      ),

    );
  }
}