import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/viewed_product_model.dart';
import 'package:keyboard_shop/pages/product_details_page.dart';
import 'package:keyboard_shop/providers/cart_provider.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/providers/viewed_products_provider.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';
import 'package:provider/provider.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({super.key});

  @override
  State<ViewedWidget> createState() => _ViewedWidget();
}

class _ViewedWidget extends State<ViewedWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final productModel = Provider.of<ViewedProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final product = productProvider.findById(productModel.productId);
    final isInCart = cartProvider.isInCartList(product.id);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ProductDetailsPage(product: product);
          },
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            product.thumbnail,
            width: 100,
            height: 100,
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
                const SizedBox(height: 4),
                Text(
                  product.isOnSale ? product.salePrice.toString() : product.price.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CusMaterialIconButton(
                      width: 54,
                      icon: isInCart ? Icons.remove_shopping_cart_outlined : Icons.shopping_cart_outlined,
                      onTap: () {
                        if (isInCart) {
                          setState(() {
                            cartProvider.deleteById(context, product.id);
                          });
                        } else {
                          cartProvider.addToCart(productId: product.id, quantity: 1);
                        }
                      },
                      color: isInCart ? Colors.redAccent : Colors.indigo,
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
