import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';
import 'package:keyboard_shop/models/order_model.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  static List<OrderModel> _orderList = [];

  List<OrderModel> get orderList => _orderList;

  OrderModel findById({required String orderId}) {
    return _orderList.firstWhere((element) => element.orderId == orderId);
  }

  Future<void> createOrder({
    required String productId,
    required String productPrice,
    required int quantity,
    required String imageUrl,
    required String totalPrice,
  }) async {
    try {
      final orderId = const Uuid().v4();
      await storeInstance.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'userId': userUid,
        'userName': user != null ? user!.displayName : '',
        'productId': productId,
        'price': productPrice * quantity,
        'quantity': quantity,
        'imageUrl': imageUrl,
        'totalPrice': totalPrice,
        'orderDate': Timestamp.now(),
      });
    } catch (err) {
      Utils.showToast(msg: err.toString());
    }
  }

  Future<void> fetchOrders() async {
    await storeInstance.collection('orders').get().then((QuerySnapshot orderSnapshot) {
      _orderList = [];

      for (var element in orderSnapshot.docs) {
        _orderList.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            productId: element.get('productId'),
            userName: element.get('userName'),
            price: element.get('price'),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantity').toString(),
            orderDate: element.get('orderDate'),
          ),
        );
      }
    });
  }
}
