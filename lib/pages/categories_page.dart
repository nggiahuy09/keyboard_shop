import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/category.dart';
import 'package:keyboard_shop/widgets/category_widget.dart';

final List<Category> category = [
  Category(name: 'Keycap', thumbnail: 'assets/images/keycap.jpg'),
  Category(name: 'Keyboard', thumbnail: 'assets/images/keyboard.jpeg'),
  Category(name: 'Gaming Mouse', thumbnail: 'assets/images/gaming_mouse.jpeg'),
];

class MyCategoriesPage extends StatelessWidget {
  const MyCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: category.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: CategoryWidget(
              assetImage: category[index].thumbnail,
              categoryName: category[index].name,
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
