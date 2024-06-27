import 'package:flutter/material.dart';
import 'package:keyboard_shop/widgets/cart_widget.dart';

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
            onPressed: () {
              if(myCart.isNotEmpty) {
                setState(() {
                  myCart.clear();
                });
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total: ......',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                MaterialButton(
                  height: 40,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  color: Colors.indigo,
                  onPressed: () {},
                  child: Text(
                    'Check Out',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
}
