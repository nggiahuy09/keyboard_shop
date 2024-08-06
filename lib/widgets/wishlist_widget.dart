import 'package:flutter/material.dart';
import 'package:keyboard_shop/pages/product_details_page.dart';
import 'package:keyboard_shop/providers/cart_provider.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/providers/wishlist_provider.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';
import 'package:provider/provider.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<WishlistWidget> createState() => _WishlistWidget();
}

class _WishlistWidget extends State<WishlistWidget> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final product = productsProvider.findById(widget.productId);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailsPage(product: product);
            },
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            product.thumbnail,
            width: 120,
            height: 120,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.isOnSale ? product.salePrice.toString() : product.price.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CusMaterialIconButton(
                      width: 54,
                      height: 36,
                      icon: Icons.delete_outline,
                      onTap: () => wishlistProvider.deleteById(context, widget.productId),
                      color: Colors.red,
                    ),
                    const SizedBox(width: 12),
                    CusMaterialIconButton(
                      width: 54,
                      height: 36,
                      icon: Icons.shopping_bag_outlined,
                      onTap: () => cartProvider.addToCart(
                        productId: widget.productId,
                        quantity: quantity,
                      ),
                      color: Colors.indigo,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
