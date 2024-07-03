import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_dialog_widget.dart';
import 'package:keyboard_shop/widgets/wishlist_widget.dart';

List<WishlistWidget> _myWishlist = [
  const WishlistWidget(),
  const WishlistWidget(),
  const WishlistWidget(),
  const WishlistWidget(),
  const WishlistWidget(),
  const WishlistWidget(),
  const WishlistWidget(),
  const WishlistWidget(),
  const WishlistWidget(),
];

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Wishlist (${_myWishlist.length})',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 26,
            ),
            onPressed: _clearWishlist,
          )
        ],
      ),
      body: _myWishlist.isEmpty
          ? const EmptyPage(
              type: ConstEmptyPage.CART,
              description: 'Your Wishlist Is Empty!!!\nVisit Our Store Now',
            )
          : ListView.builder(
              itemCount: _myWishlist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: _myWishlist[index],
                );
              },

      ),
    );
  }

  Future<void> _clearWishlist() async {
    if (_myWishlist.isNotEmpty) {
      await showDialog(
        context: context,
        builder: (context) {
          return CusConfirmationDialog(
            title: 'Confirmation',
            content: 'Do you want to clear your wishlist',
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
                setState(() {
                  _myWishlist.clear();
                });
                Navigator.of(context).pop();
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
}
