import 'package:flutter/material.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_material_button.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key});

  @override
  State<WishlistWidget> createState() => _WishlistWidget();
}

class _WishlistWidget extends State<WishlistWidget> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
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
              children: [
                const Text(
                  'Ten san phammmmmmmmmmmmmm',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Gia san pham',
                  maxLines: 1,
                  style: TextStyle(
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
                      onTap: () {},
                      color: Colors.red,
                    ),
                    const SizedBox(width: 12),
                    CusMaterialIconButton(
                      width: 54,
                      height: 36,
                      icon: Icons.shopping_bag_outlined,
                      onTap: () {},
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
