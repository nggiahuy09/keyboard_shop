import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/widgets/order_widget.dart';

List<OrderWidget> _myOrders = [
  const OrderWidget(),
  const OrderWidget(),
  const OrderWidget(),
  const OrderWidget(),
  const OrderWidget(),
  const OrderWidget(),
  const OrderWidget(),
  const OrderWidget(),
  const OrderWidget(),
  const OrderWidget(),
];

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Your Orders',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _myOrders.isEmpty
          ? const EmptyPage(
              type: ConstEmptyPage.ORDER,
              description: 'Your Orders Is Empty!!!\nPurchase Our Products Now',
            )
          : ListView.builder(
              itemCount: _myOrders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: _myOrders[index],
                );
              },
            ),
    );
  }
}
