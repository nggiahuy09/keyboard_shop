import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:keyboard_shop/auth/login_page.dart';
import 'package:keyboard_shop/consts/firebase_const.dart';
import 'package:keyboard_shop/pages/order_page.dart';
import 'package:keyboard_shop/pages/viewed_page.dart';
import 'package:keyboard_shop/pages/wishlist_page.dart';
import 'package:keyboard_shop/provider/theme_provider.dart';
import 'package:keyboard_shop/providers/wishlist_provider.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/custom_widget/cus_dialog_widget.dart';
import 'package:provider/provider.dart';

class MyUserPage extends StatefulWidget {
  const MyUserPage({super.key});

  @override
  State<MyUserPage> createState() => _MyUserPageState();
}

class _MyUserPageState extends State<MyUserPage> {
  String userAddress = 'My Address 2';

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    final wishListProvider = Provider.of<WishlistProvider>(context);

    TextEditingController addressController = TextEditingController();

    @override
    void dispose() {
      addressController.dispose();
      super.dispose();
    }

    Future<void> showUpdateAddressDialog() async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Address'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    userAddress = addressController.text.trim();
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Update'),
              ),
            ],
            content: SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userAddress,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: addressController,
                      maxLines: 5,
                      onChanged: (value) => addressController.text = value,
                      decoration: const InputDecoration(
                        hintText: 'Enter your new address',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Future<void> showLogOutDialog() async {
      await showDialog(
        context: context,
        builder: (context) {
          return CusConfirmationDialog(
            title: 'Sign Out',
            content: 'Do you wanna sign out?',
            acceptOption: TextButton(
              onPressed: () async {
                try {
                  await authInstance.signOut();

                  if (mounted) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
                  }
                } on FirebaseAuthException catch (err) {
                  if (mounted) {
                    Utils.showSnackBar(context, msg: err.message!);
                  }
                }
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            denyOption: TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          authInstance.currentUser?.email ?? 'Hi, please login your account',
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // address
            _listTile(
              title: 'Address',
              subTitle: userAddress,
              iconData: IconlyLight.profile,
              onTap: showUpdateAddressDialog,
              showTrailing: true,
            ),
            // orders
            _listTile(
              title: 'Orders',
              subTitle: null,
              iconData: IconlyLight.wallet,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const OrderPage();
              })),
              showTrailing: true,
            ),
            // wishlist
            _listTile(
              title: 'Wishlist (${wishListProvider.wishItemsList.length})',
              subTitle: null,
              iconData: IconlyLight.heart,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const WishlistPage();
                }),
              ),
              showTrailing: true,
            ),
            // viewed
            _listTile(
              title: 'Viewed',
              subTitle: null,
              iconData: IconlyLight.show,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const ViewedPage();
                }),
              ),
              showTrailing: true,
            ),
            // forget password
            _listTile(
              title: 'Forget Password',
              subTitle: null,
              iconData: IconlyLight.lock,
              onTap: () {},
              showTrailing: true,
            ),
            // theme
            SwitchListTile(
              title: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(IconlyLight.setting),
                  SizedBox(width: 16),
                  Text(
                    'Theme',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              onChanged: (bool value) {
                themeState.setTheme = value;
              },
              activeColor: Colors.indigo,
              value: themeState.getTheme,
            ),
            // log out
            _listTile(
              title: 'Log Out',
              subTitle: null,
              iconData: IconlyLight.logout,
              onTap: showLogOutDialog,
              showTrailing: false,
            ),
            if (Utils.checkHasLogin() == false)
              _listTile(
                title: 'Log In',
                subTitle: null,
                iconData: IconlyLight.login,
                onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                )),
                showTrailing: false,
              ),
          ],
        ),
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
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        subtitle: subTitle != null ? Text(subTitle) : null,
        trailing: showTrailing ? const Icon(IconlyLight.arrowRight2) : null,
        onTap: onTap,
        leading: Icon(iconData),
      ),
    );
  }
}
