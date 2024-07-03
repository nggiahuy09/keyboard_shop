import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/widgets/viewed_widget.dart';

List<ViewedWidget> _myViewed = [
  const ViewedWidget(),
  const ViewedWidget(),
  const ViewedWidget(),
  const ViewedWidget(),
  const ViewedWidget(),
  const ViewedWidget(),
  const ViewedWidget(),
  const ViewedWidget(),
  const ViewedWidget(),
  const ViewedWidget(),
];

class ViewedPage extends StatefulWidget {
  const ViewedPage({super.key});

  @override
  State<ViewedPage> createState() => _ViewedPage();
}

class _ViewedPage extends State<ViewedPage> {
  @override
  Widget build(BuildContext context) {
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
      ),
      body: _myViewed.isEmpty
          ? const EmptyPage(
              type: ConstEmptyPage.VIEWED,
              description: 'Your History Is Empty!!!\nVisit Our Store Now',
            )
          : ListView.builder(
              itemCount: _myViewed.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: _myViewed[index],
                );
              },
            ),
    );
  }
}
