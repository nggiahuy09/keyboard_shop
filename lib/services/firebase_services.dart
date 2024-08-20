import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';
import 'package:keyboard_shop/models/cart_model.dart';
import 'package:keyboard_shop/models/wishlist_model.dart';
import 'package:keyboard_shop/services/utilities.dart';

class FirebaseService {
  static Future<bool> removeFromWishlist({
    required String productId,
  }) async {
    try {
      await storeInstance.collection('users').doc(userUid).update(
        {
          'wishlist': FieldValue.arrayRemove(
            [
              {
                'productId': productId,
              },
            ],
          ),
        },
      );

      return true;
    } catch (err) {
      Utils.showToast(msg: err.toString());
    }

    return false;
  }

  static Future<bool> addToWishlist({
    required String productId,
  }) async {
    try {
      await storeInstance.collection('users').doc(userUid).update(
        {
          'wishlist': FieldValue.arrayUnion([
            {
              'productId': productId,
            }
          ]),
        },
      );

      return true;
    } catch (err) {
      Utils.showToast(msg: err.toString());
    }

    return false;
  }

  static Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      await storeInstance.collection('users').doc(userUid).update(
        {
          'cart': FieldValue.arrayUnion([
            {
              'cartId': Timestamp.now().toString(),
              'productId': productId,
              'quantity': quantity.toString(),
            }
          ]),
        },
      );

      Utils.showToast(msg: 'Add to Cart Successfully');
    } catch (err) {
      Utils.showToast(msg: err.toString());
    }
  }

  static Future<Map<String, dynamic>> getUserData() async {
    Map<String, dynamic> user = {};

    try {
      final DocumentSnapshot userDoc = await storeInstance.collection(USERS).doc(userUid).get();
      // if(userDoc == null) {
      //   return user;
      // }

      user.addAll({'id': userUid});
      user.addAll({'name': userDoc.get('name')});
      user.addAll({'email': userDoc.get('email')});
      user.addAll({'shipping_address': userDoc.get('shipping_address')});
      user.addAll({'wishlist': userDoc.get('wishlist')});
      user.addAll({'last_modify': userDoc.get('last_modify')});
    } catch (err) {
      Utils.showToast(msg: err.toString());
    }

    return user;
  }

  static Future<void> setUserFireStoreData({
    required String userUid,
    required String userName,
    required String email,
    required String address,
    Timestamp? lastModify,
    List<WishlistModel>? wishlist,
    List<CartModel>? cart,
  }) async {
    await storeInstance.collection(USERS).doc(userUid).set({
      'id': userUid,
      'name': userName,
      'email': email,
      'shipping_address': address,
      'wishlist': wishlist ?? '',
      'cart': cart ?? '',
      'last_modify': lastModify ?? Timestamp.now(),
    });
  }
}
