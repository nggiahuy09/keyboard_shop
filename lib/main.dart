import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_shop/consts/theme_data.dart';
import 'package:keyboard_shop/pages/auth/login_page.dart';
import 'package:keyboard_shop/provider/theme_provider.dart';
import 'package:keyboard_shop/providers/cart_provider.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/providers/viewed_products_provider.dart';
import 'package:keyboard_shop/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (_) => {
      runApp(const MyApp()),
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();

  void getCurrentTheme() async {
    themeProvider.setTheme = await themeProvider.darkThemePref.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => themeProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedProductProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getTheme, context),
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
