import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/cart_model.dart';
import 'package:keyboard_shop/pages/product_details_page.dart';
import 'package:keyboard_shop/providers/cart_provider.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_quantity.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    required this.cartItem,
  });

  final CartModel cartItem;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final product = productsProvider.findById(widget.cartItem.productId);

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    // todo: fix quantity logic
                    CusQuantityWidget(
                      quantity: widget.cartItem.quantity,
                      decrement: () => setState(() {
                        cartProvider.decreaseQuantity(widget.cartItem.productId);
                      }),
                      increment: () => setState(() {
                        cartProvider.increaseQuantity(widget.cartItem.productId);
                      }),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => cartProvider.deleteById(context, product.id),
                      child: const Row(
                        children: [
                          Text(
                            'Xoa',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ],
                      ),
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
