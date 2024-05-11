

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/theme/app_theme.dart';
import 'theme_state.dart';


class ThemeCubit extends Cubit<ThemeState> {

  // custom app styling
  static final ThemeData lightTheme = const AppTheme().themeData;
  static final ThemeData darkTheme = const AppDarkTheme().themeData;


  ThemeCubit() : super(ThemeState(lightTheme));


 // indicates whether to switch to dark theme and emit the state.
  void toggleTheme(bool isDark) {
    final themeData = isDark ? darkTheme : lightTheme;
    emit(ThemeState(themeData));
    _saveTheme(isDark);
  }
 
 // saves the selected theme preference
  void _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }
 
 // loads the saved theme preference from SharedPreferences, if none, defaults to light theme.
  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }
 
 // sets the initial theme based on the saved preference.
  Future<void> setInitialTheme() async {
    final isDark = await loadTheme();
    final themeData = isDark ? darkTheme : lightTheme;
    emit(ThemeState(themeData));
  }
}