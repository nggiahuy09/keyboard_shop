import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePref {
  static const THEME_STATUS = "ThemeStatus";

  // set theme with shared preferences
  setDarkTheme(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool(THEME_STATUS, value);
  }

  // get theme from shared preferences
  // if shared preferences have not set -> false (light theme)
  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(THEME_STATUS) ?? false;
  }
}
