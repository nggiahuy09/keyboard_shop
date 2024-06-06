import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xFF00001a) : Colors.white,
      primaryColor: const Color.fromARGB(255, 5, 5, 5),
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: isDarkTheme ? const Color(0xFF1a1f3c) : Colors.white,
            onSurface: isDarkTheme ? Colors.white : const Color(0xFF00001a),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      cardColor: isDarkTheme ? const Color(0xFF0a0d2c) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.white,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light(),
          ),
      navigationBarTheme: NavigationBarThemeData(
        surfaceTintColor: isDarkTheme ? Colors.white : const Color(0xFF0a0d2c),
        backgroundColor: isDarkTheme ? Colors.white : const Color(0xFF0a0d2c),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDarkTheme ? Colors.indigo.shade800 : Colors.white,
        selectedItemColor: isDarkTheme ? Colors.white : Colors.indigo.shade800,
        selectedIconTheme: IconThemeData(
            color: isDarkTheme ? Colors.white : Colors.indigo.shade800),
        showUnselectedLabels: false,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.white : const Color(0xFF00001a),
      ),
      listTileTheme: ListTileThemeData(
        textColor: isDarkTheme ? Colors.white : const Color(0xFF00001a),
        iconColor: isDarkTheme ? Colors.white : const Color(0xFF00001a),
      )
    );
  }
}
