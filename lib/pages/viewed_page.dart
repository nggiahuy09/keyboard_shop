import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/providers/viewed_products_provider.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/viewed_widget.dart';
import 'package:provider/provider.dart';

class ViewedPage extends StatefulWidget {
  const ViewedPage({super.key});

  @override
  State<ViewedPage> createState() => _ViewedPage();
}

class _ViewedPage extends State<ViewedPage> {
  @override
  Widget build(BuildContext context) {
    final viewedListProvider = Provider.of<ViewedProductProvider>(context);
    final viewedList = viewedListProvider.viewedListItems;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'History',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 26,
            ),
            onPressed: () {
              if (viewedList.isNotEmpty) {
                viewedListProvider.clearViewedList(context);
              } else {
                Utils.showToast(msg: 'Your History is Empty');
              }
            },
          )
        ],
      ),
      body: viewedList.isEmpty
          ? const EmptyPage(
              type: ConstEmptyPage.VIEWED,
              description: 'Your History Is Empty!!!\nVisit Our Store Now',
            )
          : ListView.builder(
              itemCount: viewedList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ChangeNotifierProvider.value(
                    value: viewedList[index],
                    child: const ViewedWidget(),
                  ),
                );
              },
            ),
    );
  }
}
