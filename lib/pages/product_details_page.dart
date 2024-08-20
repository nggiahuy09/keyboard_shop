import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/product_model.dart';
import 'package:keyboard_shop/providers/cart_provider.dart';
import 'package:keyboard_shop/providers/viewed_products_provider.dart';
import 'package:keyboard_shop/providers/wishlist_provider.dart';
import 'package:keyboard_shop/services/firebase_services.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_quantity.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final viewedListProvider = Provider.of<ViewedProductProvider>(context);

    viewedListProvider.addToViewed(productId: widget.product.id);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.product.thumbnail,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  left: 16,
                  top: 56,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Price:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.product.isOnSale ? widget.product.salePrice.toString() : widget.product.price.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        if (widget.product.isOnSale)
                          Text(
                            widget.product.price.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Category:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.product.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quantity:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        CusQuantityWidget(
                          quantity: quantity,
                          decrement: decrement,
                          increment: increment,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  CusMaterialButton(
                    content: 'Add to Cart',
                    subContent: 'Free Shipping',
                    onTap: () async {
                      if (Utils.checkHasLogin()) {
                        await FirebaseService.addToCart(
                          productId: widget.product.id,
                          quantity: quantity,
                        );
                        await cartProvider.fetchCart();
                      } else {
                        Utils.showToast(msg: 'Please Login to continue...');
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  CusMaterialButtonAccent(
                    content: 'Add to Wishlist',
                    onTap: () async {
                      if (Utils.checkHasLogin()) {
                        await FirebaseService.addToWishlist(productId: widget.product.id);
                        await wishlistProvider.fetchWishlist();

                        Utils.showToast(msg: 'Add to Wishlist Successfully');
                      } else {
                        Utils.showToast(msg: 'Please Login to continue...');
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }
}
