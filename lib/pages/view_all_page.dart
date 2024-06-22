import 'package:flutter/material.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/product_item_widget.dart';

class ViewAllPage extends StatelessWidget {
  const ViewAllPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenSize = Utils(context).screenSize;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // body: const EmptyPage(description: 'No Product Item on Sale',),
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        childAspectRatio: screenSize.width / (screenSize.height * 0.78),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(
          5,
          (index) => const ProductItemWidget(),
        ),
      ),
    );
  }
}
