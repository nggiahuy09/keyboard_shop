import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String id, productId;
  int quantity;

  CartModel({
    required this.id,
    required this.productId,
    required this.quantity,
  });
}
