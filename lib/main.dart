import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_shop/consts/theme_data.dart';
import 'package:keyboard_shop/auth/login_page.dart';
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

  final Future<FirebaseApp> initilization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initilization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('An Error Occurred\n Try Again'),
              ),
            ),
          );
        } else {
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
      },
    );
  }
}
