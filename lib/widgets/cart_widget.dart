import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/keycap.jpg',
            width: 120,
            height: 120,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ten san phammmmmmmmmmmmmm',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Gia san pham',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          quantity < 10 ? '0$quantity' : '$quantity',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
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
