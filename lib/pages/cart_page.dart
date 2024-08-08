import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/providers/cart_provider.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/cart_widget.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';
import 'package:provider/provider.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final myCart = cartProvider.cartItems.values.toList();
    final totalPrice = cartProvider.totalPrice(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart (${myCart.length})'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 26,
            ),
            onPressed: () {
              if (myCart.isNotEmpty) {
                cartProvider.clearCart(context);
              } else {
                Utils.showToast(msg: 'Your Cart is Empty');
              }
            },
          )
        ],
      ),
      body: myCart.isEmpty
          ? const EmptyPage(
              type: ConstEmptyPage.CART,
              description: 'Your Cart is Empty!!!\nGo Shopping Now',
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${totalPrice.toString()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CusMaterialButton(
                        content: 'Check Out',
                        minWidth: 100,
                        fontSizeContent: 18,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: ListView.builder(
                      itemCount: myCart.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ChangeNotifierProvider.value(
                            value: myCart[index],
                            child: CartWidget(cartItem: myCart[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
