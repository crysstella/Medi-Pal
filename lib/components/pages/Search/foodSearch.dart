import 'package:flutter/material.dart';

class FoodSearch extends StatefulWidget{
  const FoodSearch({super.key});

  @override
  State<FoodSearch> createState() =>_FoodSearchState();
}

class _FoodSearchState extends State<FoodSearch> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Food Search')]),
      ),
    );
  }
}