import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';
import 'package:keyboard_shop/models/cart_model.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_dialog_widget.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> get cartItems => _cartItems;
  
  bool isInCartList(String id) {
    final itemsList = _cartItems.values.toList();
    bool inList = false;

    for (final item in itemsList) {
      if (item.productId == id) {
        inList = true;
        break;
      }
    }

    return inList;
  }

  CartModel? findByProductId({required String productId}) {
    final itemsList = _cartItems.values.toList();

    for (final item in itemsList) {
      if (item.productId == productId) {
        return CartModel(
          id: item.id,
          productId: item.productId,
          quantity: item.quantity,
        );
      }
    }

    return null;
  }

  Future<void> clearCart(BuildContext context) async {
    if (_cartItems.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return CusConfirmationDialog(
            title: 'Confirmation',
            content: 'Do you want to clear your cart',
            denyOption: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
            ),
            acceptOption: TextButton(
              onPressed: () async {
                _cartItems.clear();

                await storeInstance.collection('users').doc(userUid).update({
                  'cart': [],
                });

                notifyListeners();
                Navigator.of(context).maybePop();
                Utils.showToast(msg: 'Clear Cart Successfully');
              },
              child: const Text(
                'Clear',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      );
    }
  }

  // todo: complete this function to update the quantity of product in cart on Firebase
  Future<void> updateQuantity() async {
    try {

    } catch (err) {
      Utils.showToast(msg: err.toString());
    }
  }

  Future<void> fetchCart() async {
    try {
      final DocumentSnapshot snapshot = await storeInstance.collection('users').doc(userUid).get();

      if (!snapshot.exists) return;
      final cartLength = snapshot.get('cart').length;

      for (int i = 0; i < cartLength; i++) {
        final String cartId = snapshot.get('cart')[i]['cartId'];
        final String productId = snapshot.get('cart')[i]['productId'];
        final int quantity = int.parse(snapshot.get('cart')[i]['quantity']);

        _cartItems.putIfAbsent(
          snapshot.get('cart')[i]['productId'],
          () => CartModel(
            id: cartId,
            productId: productId,
            quantity: quantity,
          ),
        );

        notifyListeners();
      }
    } catch (err) {
      Utils.showToast(msg: err.toString());
    }
  }

  Future<void> deleteById(BuildContext context, String productId) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CusConfirmationDialog(
          title: 'Confirmation',
          content: 'Are you sure to remove this product?',
          acceptOption: TextButton(
            onPressed: () {
              _cartItems.removeWhere((key, value) => value.productId == productId);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: Colors.red),
            ),
          ),
          denyOption: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
            ),
          ),
        );
      },
    );

    notifyListeners();
  }

  void increaseQuantity(String productId) {
    CartModel cartItem = _cartItems.values.toList().firstWhere((element) => element.productId == productId);

    cartItem.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    CartModel cartItem = _cartItems.values.toList().firstWhere((element) => element.productId == productId);

    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      Utils.showToast(msg: 'Can not Decrease Anymore');
    }
    notifyListeners();
  }

  double totalPrice(ProductsProvider productsProvider) {
    double result = 0.0;

    for (final c in _cartItems.values.toList()) {
      result += productsProvider.findPriceById(c.productId) * c.quantity;
    }

    notifyListeners();
    return result;
  }

  final Map<String, CartModel> _cartItems = {};
}
