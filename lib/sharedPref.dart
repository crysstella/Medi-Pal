import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// function to save email 
Future<void> saveEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}

// function to retrieve email 
Future<String?> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

// function to save favorite foods
Future<void> saveFavoriteFoods(List<String> favoriteFoods) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('favoriteFoods', favoriteFoods);
}

// function to retrieve favorite foods 
Future<List<String>?> getFavoriteFoods() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('favoriteFoods');
}

// function to retrieve calories
Future<double?> getCalories() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble('calories');
}

// function to retrieve water goal
Future<double?> getWater() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble('waterGoal');
}