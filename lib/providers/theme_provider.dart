import 'package:flutter/material.dart';
import 'package:keyboard_shop/services/dark_theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _darkTheme = false;
  DarkThemePref darkThemePref = DarkThemePref();

  bool get getTheme => _darkTheme;

  set setTheme(bool isDarkTheme) {
    _darkTheme = isDarkTheme;
    darkThemePref.setDarkTheme(isDarkTheme);

    notifyListeners();
  }
}
