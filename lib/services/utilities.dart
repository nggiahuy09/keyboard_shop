
import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  Size get screenSize => MediaQuery.of(context).size;
  Color get primaryColor => Theme.of(context).colorScheme.inversePrimary;

  static void showSnackBar(BuildContext context, {required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
        ),
      ),
    );
  }

  static bool checkHasLogin() {
    return authInstance.currentUser?.uid != null ? true : false;
  }
}