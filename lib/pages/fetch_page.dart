import 'package:flutter/material.dart';
import 'package:keyboard_shop/pages/bottom_bar_page.dart';
import 'package:keyboard_shop/providers/cart_provider.dart';
import 'package:keyboard_shop/providers/order_provider.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/providers/wishlist_provider.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:provider/provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 5)).then(
      (_) async {
        final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
        await productsProvider.fetchProducts();

        if (Utils.checkHasLogin()) {
          if (mounted) {
            final cartProvider = Provider.of<CartProvider>(context, listen: false);
            final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
            final orderProvider = Provider.of<OrderProvider>(context, listen: false);

            await cartProvider.fetchCart();
            await wishlistProvider.fetchWishlist();
            await orderProvider.fetchOrders();
          }
        }

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const MyBottomBarPage();
              },
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/app_icon.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
