import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:keyboard_shop/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MyUserPage extends StatelessWidget {
  const MyUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'nggiahuy09@gmail.com',
      //     style: TextStyle(fontSize: 16),
      //   ),
      // ),
      body: Column(
        children: [
          _listTile(
            title: 'Address',
            subTitle: 'My Address 2',
            iconData: IconlyLight.profile,
            onTap: () {},
            showTrailing: true,
          ),
          _listTile(
            title: 'Orders',
            subTitle: null,
            iconData: IconlyLight.wallet,
            onTap: () {},
            showTrailing: true,
          ),
          _listTile(
            title: 'Wishlist',
            subTitle: null,
            iconData: IconlyLight.heart,
            onTap: () {},
            showTrailing: true,
          ),
          _listTile(
            title: 'Viewed',
            subTitle: null,
            iconData: IconlyLight.show,
            onTap: () {},
            showTrailing: true,
          ),
          _listTile(
            title: 'Forget Password',
            subTitle: null,
            iconData: IconlyLight.lock,
            onTap: () {},
            showTrailing: true,
          ),
          SwitchListTile(
            title: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(IconlyLight.setting),
                SizedBox(width: 16),
                Text('Theme'),
              ],
            ),
            onChanged: (bool value) {
              themeState.setTheme = value;
            },
            activeColor: Colors.indigo,
            value: themeState.getTheme,
          ),
          _listTile(
            title: 'Log Out',
            subTitle: null,
            iconData: IconlyLight.logout,
            onTap: () {},
            showTrailing: false,
          ),
        ],
      ),
    );
  }

  Widget _listTile({
    required String title,
    required String? subTitle,
    required IconData iconData,
    required Function() onTap,
    required bool showTrailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        title: Text(title),
        subtitle: subTitle != null ? Text(subTitle) : null,
        trailing: showTrailing ? const Icon(IconlyLight.arrowRight2) : null,
        onTap: onTap,
        leading: Icon(iconData),
      ),
    );
  }
}
