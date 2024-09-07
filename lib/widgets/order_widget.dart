import 'package:flutter/material.dart';
import 'package:keyboard_shop/providers/order_provider.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);

    final order = orderProvider.findById(orderId: orderId);
    final product = productProvider.findById(order.productId);

    final String orderDate = '${order.orderDate.toDate().day}/${order.orderDate.toDate().month}/${order.orderDate.toDate().year}';
    return GestureDetector(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            order.imageUrl,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  order.price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      orderDate,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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
