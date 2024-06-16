import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.assetImage,
    required this.categoryName,
    required this.onTap,
  });

  final String assetImage;
  final String categoryName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(assetImage),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
