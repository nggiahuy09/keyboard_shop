import 'package:flutter/material.dart';
import 'package:keyboard_shop/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Center(
        child: SwitchListTile(
          title: const Text('Theme'),
          onChanged: (bool value) {
            themeState.setTheme = value;
          },
          value: themeState.getTheme,
        ),
      ),
    );
  }
}
