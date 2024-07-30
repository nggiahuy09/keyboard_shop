enum Category {
  keyboard,
  gamingMouse,
  keycap
}

class CategoryModel {
  final String name;
  final String thumbnail;

  CategoryModel({
    required this.name,
    required this.thumbnail,
  });
}
