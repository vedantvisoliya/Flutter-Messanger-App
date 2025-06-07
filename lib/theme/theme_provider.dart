import 'package:flutter/material.dart';
import 'light_mode.dart';
import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initializing the theme
  ThemeData _themeData = lightMode;

  // getter
  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  // toggle mode
  void toggleTheme() {
    if(_themeData == lightMode){
      themeData = darkMode;
    }
    else {
      themeData = lightMode;
    }
  }
}