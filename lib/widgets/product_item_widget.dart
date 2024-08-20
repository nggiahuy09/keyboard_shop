import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:keyboard_shop/models/product_model.dart';
import 'package:keyboard_shop/pages/product_details_page.dart';
import 'package:keyboard_shop/providers/wishlist_provider.dart';
import 'package:keyboard_shop/services/firebase_services.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:provider/provider.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    super.key,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidget();
}

class _ProductItemWidget extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final size = Utils(context).screenSize;
    final product = Provider.of<ProductModel>(context);
    final wishListProvider = Provider.of<WishlistProvider>(context);
    final isInWishList = wishListProvider.isInWishlist(product.id);

    return SizedBox(
      width: size.width * 0.42,
      height: 200,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductDetailsPage(product: product);
          }));
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.thumbnail,
                height: size.width * 0.42,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.isOnSale ? product.salePrice.toString() : product.price.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  if (product.isOnSale)
                    Text(
                      product.price.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (Utils.checkHasLogin()) {
                        if (isInWishList) {
                          if (await FirebaseService.removeFromWishlist(productId: product.id)) {
                            Utils.showToast(msg: 'Remove from Wishlist Successfully');
                          }

                          wishListProvider.deleteById(context, product.id);
                          await wishListProvider.fetchWishlist();
                        } else {
                          if (await FirebaseService.addToWishlist(productId: product.id)) {
                            Utils.showToast(msg: 'Add to Wishlist Successfully');
                          }
                          await wishListProvider.fetchWishlist();
                        }
                      } else {
                        Utils.showToast(msg: 'Please Login to continue...');
                      }
                    },
                    child: Icon(
                      isInWishList ? IconlyBold.heart : IconlyLight.heart,
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
