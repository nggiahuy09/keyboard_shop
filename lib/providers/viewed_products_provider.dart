import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/viewed_product_model.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_dialog_widget.dart';

class ViewedProductProvider with ChangeNotifier {
  final Map<String, ViewedProductModel> _viewedProducts = {};

  List<ViewedProductModel> get viewedListItems => _viewedProducts.values.toList();

  void clearLocalData() => _viewedProducts.clear();

  void clearViewedList(BuildContext context) {
    if (_viewedProducts.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return CusConfirmationDialog(
            title: 'Confirmation',
            content: 'Do you want to clear your history list',
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
                _viewedProducts.clear();
                notifyListeners();
                Navigator.of(context).maybePop();

                Utils.showToast(msg: 'Clear History Successfully');
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

  void addToViewed({required String productId}) {
    _viewedProducts.putIfAbsent(
      productId,
      () => ViewedProductModel(id: DateTime.now().toString(), productId: productId),
    );

    notifyListeners();
  }
}
