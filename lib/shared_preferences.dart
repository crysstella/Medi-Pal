import 'package:shared_preferences/shared_preferences.dart';

// Function to save email using shared preferences
Future<void> saveEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}

// Function to retrieve email using shared preferences
Future<String?> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

// Function to save favorite foods using shared preferences
Future<void> saveFavoriteFoods(List<String> favoriteFoods) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('favoriteFoods', favoriteFoods);
}

// Function to retrieve favorite foods using shared preferences
Future<List<String>?> getFavoriteFoods() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('favoriteFoods');
}