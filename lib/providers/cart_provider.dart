import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/cart_model.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
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

  void clearCart(BuildContext context)  {
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
              onPressed: () {
                _cartItems.clear();
                notifyListeners();
                Navigator.of(context).maybePop();
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

  void addToCart({
    required String productId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(id: DateTime.now().toString(), productId: productId, quantity: quantity),
    );

    notifyListeners();
  }

  void deleteById(BuildContext context, String productId) async {
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
      // todo: show dialog can not decrease any more
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
