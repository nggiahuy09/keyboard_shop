import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/pages/view_all_page.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/product_item_widget.dart';
import 'package:provider/provider.dart';

final List<String> cardSwiper = [
  'assets/images/card_swiper_1.jpg',
  'assets/images/card_swiper_2.jpeg',
  'assets/images/gaming_mouse.jpeg',
  'assets/images/keycap.jpg',
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = Utils(context).screenSize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = productsProvider.products;
    final saleProducts = productsProvider.saleProducts;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize.height * 0.3,
              child: Swiper(
                autoplay: true,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Theme.of(context).colorScheme.background,
                    activeColor: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                itemCount: cardSwiper.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    cardSwiper[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            sectionWidget(
              context,
              title: 'For You',
              viewAll: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ViewAllPage(
                      title: 'For You',
                      isSalePage: true,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.only(left: 8),
              height: screenSize.height * 0.34,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: saleProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ChangeNotifierProvider.value(
                      value: saleProducts[index],
                      child: const ProductItemWidget(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            sectionWidget(
              context,
              title: 'Our Gears',
              viewAll: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ViewAllPage(title: 'Our Gears'),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: screenSize.width / (screenSize.height * 0.78),
              children: List.generate(
                products.length,
                (index) {
                  return ChangeNotifierProvider.value(
                    value: products[index],
                    child: const ProductItemWidget(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionWidget(
    BuildContext context, {
    required String title,
    required Function() viewAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: viewAll,
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
