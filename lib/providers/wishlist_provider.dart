import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';
import 'package:keyboard_shop/models/wishlist_model.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_dialog_widget.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishItems = {};

  Map<String, WishlistModel> get wishItems => _wishItems;
  List<WishlistModel> get wishItemsList => _wishItems.values.toList();

  void clearLocalData() => _wishItems.clear();

  bool isInWishlist(String id) {
    final itemsList = _wishItems.values.toList();
    bool inList = false;

    for (final item in itemsList) {
      if (item.productId == id) {
        inList = true;
        break;
      }
    }

    return inList;
  }

  Future<void> fetchWishlist() async {
    try {
      final DocumentSnapshot snapshot = await storeInstance.collection('users').doc(userUid).get();

      if (!snapshot.exists) return;
      final wishlistLength = snapshot.get('wishlist').length;

      for (int i = 0; i < wishlistLength; i++) {
        final String productId = snapshot.get('wishlist')[i]['productId'];

        _wishItems.putIfAbsent(
          snapshot.get('wishlist')[i]['productId'],
          () => WishlistModel(
            id: Timestamp.now().toString(),
            productId: productId,
          ),
        );

        notifyListeners();
      }
    } catch (err) {
      Utils.showToast(msg: err.toString());
    }
  }

  Future<void> clearWishlist(BuildContext context) async{
    if (_wishItems.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return CusConfirmationDialog(
            title: 'Confirmation',
            content: 'Do you want to clear your wish list',
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
                _wishItems.clear();

                await storeInstance.collection('users').doc(userUid).update({
                  'wishlist': [],
                });

                notifyListeners();
                Navigator.of(context).maybePop();

                Utils.showToast(msg: 'Clear Wish List Successfully');
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

  void addToWishlist({required String productId}) {
    _wishItems.putIfAbsent(
      productId,
      () => WishlistModel(id: DateTime.now().toString(), productId: productId),
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
              _wishItems.removeWhere((key, value) => value.productId == productId);
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
}
