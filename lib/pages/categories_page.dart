import 'package:flutter/material.dart';
import 'package:keyboard_shop/models/category_model.dart';
import 'package:keyboard_shop/widgets/category_widget.dart';

final List<CategoryModel> category = [
  CategoryModel(name: 'Keycap', thumbnail: 'assets/images/keycap.jpg'),
  CategoryModel(name: 'Keyboard', thumbnail: 'assets/images/keyboard.jpeg'),
  CategoryModel(name: 'Gaming Mouse', thumbnail: 'assets/images/gaming_mouse.jpeg'),
];

class MyCategoriesPage extends StatelessWidget {
  const MyCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
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
