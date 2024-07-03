import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    super.key,
    required this.description,
    required this.type,
  });

  final String description;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _getType(),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          const SizedBox(height: 40),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _getType() {
    var result = '';

    switch (type) {
      case ConstEmptyPage.CART:
        result = 'assets/images/empty_cart.png';
        break;
      case ConstEmptyPage.ORDER:
        result = 'assets/images/empty_order.png';
        break;
      case ConstEmptyPage.SEARCH:
        result = 'assets/images/empty_search.png';
        break;
      case ConstEmptyPage.VIEWED:
        result = 'assets/images/empty_viewed.png';
        break;
      default:
        break;
    }

    return result;
  }
}
