import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/providers/viewed_products_provider.dart';
import 'package:keyboard_shop/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

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

  static void showToast({
    required String msg,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 1,
    Color backgroundColor = Colors.indigo,
    Color textColor = Colors.white,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: toastGravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static void deleteAllLocalData(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
    final historyProvider = Provider.of<ViewedProductProvider>(context, listen: false);

    productsProvider.clearLocalData();
    wishlistProvider.clearLocalData();
    historyProvider.clearLocalData();
  }
}