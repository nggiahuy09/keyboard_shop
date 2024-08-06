import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/providers/wishlist_provider.dart';
import 'package:keyboard_shop/widgets/wishlist_widget.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final myWishlist = wishlistProvider.wishItems.values.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Wishlist (${myWishlist.length})',
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
            onPressed: () => wishlistProvider.clearWishlist(context),
          )
        ],
      ),
      body: myWishlist.isEmpty
          ? const EmptyPage(
              type: ConstEmptyPage.CART,
              description: 'Your Wishlist Is Empty!!!\nVisit Our Store Now',
            )
          : ListView.builder(
              itemCount: myWishlist.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: myWishlist[index],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: WishlistWidget(productId: myWishlist[index].productId),
                  ),
                );
              },

      ),
    );
  }
}
