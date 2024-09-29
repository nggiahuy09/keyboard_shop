import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/providers/order_provider.dart';
import 'package:keyboard_shop/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final ordersList = orderProvider.orderList;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Orders (${ordersList.length})',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ordersList.isEmpty
          ? const EmptyPage(
              type: ConstEmptyPage.ORDER,
              description: 'Your Orders Is Empty!!!\nPurchase Our Products Now',
            )
          : ListView.builder(
              itemCount: ordersList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: ordersList[index],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: OrderWidget(
                      orderId: ordersList[index].orderId,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
