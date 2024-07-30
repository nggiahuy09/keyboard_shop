import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/category_model.dart';
import 'package:keyboard_shop/models/product_model.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductModel> get products {
    return _mockData;
  }

  List<ProductModel> get saleProducts {
    return _mockData.where((element) => element.isOnSale).toList();
  }

  ProductModel findById(String id) {
    return _mockData.firstWhere((element) => element.id == id);
  }

  static final List<ProductModel> _mockData = [
    ProductModel(
      id: '001',
      title: 'MCHOSE GX87 - Bàn phím cơ khung nhôm TKL 3 Mode, có tạ',
      category: Category.keyboard.name.toString(),
      thumbnail: 'assets/mock_images/mchose_gx87.jpeg',
      price: 1399000,
      salePrice: 1000000,
      isOnSale: true,
    ),
    ProductModel(
      id: '002',
      title: 'CRUSH80 - Bàn phím cơ TKL khung nhôm CNC cao cấp',
      category: Category.keyboard.name.toString(),
      thumbnail: 'assets/mock_images/crush80.jpeg',
      price: 2600,
      salePrice: 0,
    ),
    ProductModel(
      id: '003',
      title: 'Bàn phím cơ Fullsize MONKA 3108 mode mạch xuôi',
      category: Category.keyboard.name.toString(),
      thumbnail: 'assets/mock_images/monka3108_fullsize.jpeg',
      price: 1350,
      salePrice: 0,
    ),
    ProductModel(
      id: '004',
      title: 'Bàn phím cơ công thái học RECORD ALICE 3 mode - ONLY KIT',
      category: Category.keyboard.name.toString(),
      thumbnail: 'assets/mock_images/record_alice.jpeg',
      price: 1300,
      salePrice: 0,
    ),
    ProductModel(
      id: '005',
      title: 'Bàn phím cơ FURYCUBE F75 - Khung nhôm CNC núm xoay cao cấp',
      category: Category.keyboard.name.toString(),
      thumbnail: 'assets/mock_images/furycube_f75.jpeg',
      price: 1699,
      salePrice: 0,
    ),
  ];

}