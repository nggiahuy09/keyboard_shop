import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';
import 'package:keyboard_shop/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  static final List<ProductModel> _productsList = [];

  void clearLocalData() => _productsList.clear();

  Future<void> fetchProducts() async {
    await storeInstance.collection('products').get().then((QuerySnapshot snapshot) {
      for (var element in snapshot.docs) {
        _productsList.add(
          ProductModel(
            id: element.get('id'),
            title: element.get('title'),
            category: element.get('category'),
            thumbnail: element.get('image_url'),
            price: double.tryParse(element.get('price')) ?? 0.0,
            salePrice: double.tryParse(element.get('sale_price')) ?? 0.0,
            isOnSale: element.get('is_on_sale') as bool,
            productInfo: element.get('product_information'),
          ),
        );
      }
    });

    log('length = ${_productsList.length}');
  }

  List<ProductModel> get products {
    return _productsList;
  }

  List<ProductModel> get saleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  ProductModel findById(String id) {
    return _productsList.firstWhere((element) => element.id == id);
  }

  List<ProductModel> findByCategory(String category) {
    return _productsList.where((element) => element.category.toLowerCase() == category.toLowerCase()).toList();
  }

  List<ProductModel> findByName(String name) {
    return _productsList.where((element) => element.title.toLowerCase().contains(name.toLowerCase())).toList();
  }

  double findPriceById(String id) {
    final product = _productsList.firstWhere((element) => element.id == id);

    return product.isOnSale ? product.salePrice : product.price;
  }

// static final List<ProductModel> _mockData = [
//   ProductModel(
//     id: '001',
//     title: 'MCHOSE GX87 - Bàn phím cơ khung nhôm TKL 3 Mode, có tạ',
//     category: Category.keyboard.name.toString(),
//     thumbnail: 'assets/mock_images/mchose_gx87.jpeg',
//     price: 1399000,
//     salePrice: 1000000,
//     isOnSale: true,
//   ),
//   ProductModel(
//     id: '002',
//     title: 'CRUSH80 - Bàn phím cơ TKL khung nhôm CNC cao cấp',
//     category: Category.keyboard.name.toString(),
//     thumbnail: 'assets/mock_images/crush80.jpeg',
//     price: 2600,
//     salePrice: 0,
//   ),
//   ProductModel(
//     id: '003',
//     title: 'Bàn phím cơ Fullsize MONKA 3108 mode mạch xuôi',
//     category: Category.keyboard.name.toString(),
//     thumbnail: 'assets/mock_images/monka3108_fullsize.jpeg',
//     price: 1350,
//     salePrice: 0,
//   ),
//   ProductModel(
//     id: '004',
//     title: 'Bàn phím cơ công thái học RECORD ALICE 3 mode - ONLY KIT',
//     category: Category.keyboard.name.toString(),
//     thumbnail: 'assets/mock_images/record_alice.jpeg',
//     price: 1300,
//     salePrice: 0,
//   ),
//   ProductModel(
//     id: '005',
//     title: 'Bàn phím cơ FURYCUBE F75 - Khung nhôm CNC núm xoay cao cấp',
//     category: Category.keyboard.name.toString(),
//     thumbnail: 'assets/mock_images/furycube_f75.jpeg',
//     price: 1699,
//     salePrice: 0,
//   ),
// ];
}
