import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:keyboard_shop/pages/cart_page.dart';
import 'package:keyboard_shop/pages/categories_page.dart';
import 'package:keyboard_shop/pages/home_page.dart';
import 'package:keyboard_shop/pages/user_page.dart';

class MyBottomBarPage extends StatefulWidget {
  const MyBottomBarPage({super.key});

  @override
  State<MyBottomBarPage> createState() => _MyBottomBarPage();
}

class _MyBottomBarPage extends State<MyBottomBarPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _page = [
    {
      'page': const MyHomePage(),
      // 'title': 'Home',
    },
    {
      'page': const MyCategoriesPage(),
      // 'title': 'Categories',
    },
    {
      'page': const MyCartPage(),
      // 'title': 'Cart',
    },
    {
      'page': const MyUserPage(),
      // 'title': 'Hi, Customer',
    },
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_page[_selectedIndex]['title']),
      // ),
      body: _page[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            activeIcon: Icon(IconlyBold.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.category),
            activeIcon: Icon(IconlyBold.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: Text(
                '0',
                style: TextStyle(color: Theme.of(context).colorScheme.background),
              ),
              badgeStyle: badges.BadgeStyle(badgeColor: Theme.of(context).colorScheme.inversePrimary),
              child: const Icon(IconlyLight.buy),
            ),
            activeIcon: badges.Badge(
              badgeContent: Text(
                '0',
                style: TextStyle(color: Theme.of(context).colorScheme.background),
              ),
              badgeStyle: badges.BadgeStyle(badgeColor: Theme.of(context).colorScheme.inversePrimary),
              child: const Icon(IconlyBold.buy),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.user2),
            activeIcon: Icon(IconlyBold.user2),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
