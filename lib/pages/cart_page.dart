import 'package:flutter/material.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/widgets/cart_widget.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_dialog_widget.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';

List<CartWidget> myCart = [
  const CartWidget(),
  const CartWidget(),
  const CartWidget(),
  const CartWidget(),
  const CartWidget(),
  const CartWidget(),
  const CartWidget(),
  const CartWidget(),
  const CartWidget(),
  const CartWidget(),
];

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart (${myCart.length})'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 26,
            ),
            onPressed: _clearCart,
          )
        ],
      ),
      body: myCart.isEmpty
          ? const EmptyPage(description: 'Your Cart is Empty!!!\nGo Shopping Now')
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total: ......',
                        style: TextStyle(
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
                          child: myCart[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _clearCart() async {
    if (myCart.isNotEmpty) {
      await showDialog(
        context: context,
        builder: (context) {
          return CusConfirmationDialog(
            title: 'Confirmation',
            content: 'Do you want to clear your cart',
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
                  myCart.clear();
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
