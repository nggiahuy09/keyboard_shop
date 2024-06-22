import 'package:flutter/material.dart';
import 'package:keyboard_shop/services/utilities.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    super.key,
    this.isSale = false,
  });

  final bool isSale;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidget();
}

class _ProductItemWidget extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final size = Utils(context).screenSize;

    return SizedBox(
      width: size.width * 0.42,
      height: 200,
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/keycap.jpg',
                // height: size.width * 0.42,
                // width: double.infinity,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 8),
              const Text(
                'Keycap astronautttttt',
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1.999.000',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                  ),
                  if (widget.isSale)
                    Text(
                      '1.999.000',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Keycap',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
