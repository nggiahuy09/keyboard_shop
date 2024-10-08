import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String id, title, category, thumbnail, productInfo;
  final double price, salePrice;
  final bool isOnSale;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.price,
    required this.salePrice,
    required this.productInfo,
    this.isOnSale = false,
  });
}
