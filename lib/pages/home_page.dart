import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/on_sale_widget.dart';

final List<String> cardSwiper = [
  'assets/images/card_swiper_1.jpg',
  'assets/images/card_swiper_2.jpeg',
  'assets/images/gaming_mouse.jpeg',
  'assets/images/keycap.jpg',
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = Utils(context).screenSize;

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
              viewAlls: () {},
            ),
            Container(
              padding: const EdgeInsets.only(left: 4),
              height: screenSize.height * 0.34,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: OnSaleWidget(),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            sectionWidget(
              context,
              title: 'Our Gears',
              viewAlls: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionWidget(
    BuildContext context, {
    required String title,
    required Function() viewAlls,
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
            onTap: viewAlls,
            child: Text(
              'View alls',
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
