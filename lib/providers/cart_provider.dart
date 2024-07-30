import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> get cartItems => _cartItems;

  void addToCart({
    required String productId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(id: DateTime.now().toString(), productId: productId, quantity: quantity),
    );
  }

  Map<String, CartModel> _cartItems = {};
}
