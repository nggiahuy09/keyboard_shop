import 'package:flutter/material.dart';
import 'package:keyboard_shop/consts/empty_screen_data.dart';
import 'package:keyboard_shop/models/product_model.dart';
import 'package:keyboard_shop/pages/empty_page.dart';
import 'package:keyboard_shop/providers/products_provider.dart';
import 'package:keyboard_shop/services/utilities.dart';
import 'package:keyboard_shop/widgets/product_item_widget.dart';
import 'package:provider/provider.dart';

class ViewAllPage extends StatefulWidget {
  const ViewAllPage({
    super.key,
    required this.title,
    this.isSalePage = false,
    this.isCategoryPage = false,
  });

  final String title;
  final bool isSalePage;
  final bool isCategoryPage;

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  final TextEditingController _searchTextController = TextEditingController();
  List<ProductModel> products = [];

  var isSearching = false;

  @override
  void initState() {
    products = _getProducts(context);
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> _getProducts(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);

    final products = widget.isCategoryPage
        ? productsProvider.findByCategory(widget.title)
        : widget.isSalePage
            ? productsProvider.saleProducts
            : productsProvider.products;

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = Utils(context).screenSize;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            isSearching
                ? setState(() {
                    isSearching = !isSearching;
                  })
                : Navigator.of(context).pop();
          },
        ),
        actions: [
          !isSearching || _searchTextController.text.trim().isEmpty
              ? IconButton(
                  icon: const Icon(Icons.search, size: 26),
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.close, size: 26),
                  onPressed: () {
                    setState(() {
                      _searchTextController.clear();
                      products = _getProducts(context);
                    });
                  }),
        ],
        title: isSearching
            ? TextField(
                controller: _searchTextController,
                onChanged: (value) {
                  setState(() {
                    products = Provider.of<ProductsProvider>(context, listen: false).findByName(value);
                  });
                },
                onSubmitted: (value) {},
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What are you looking for?',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.background.withOpacity(0.8),
                    fontStyle: FontStyle.normal,
                  ),
                ),
              )
            : Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
      // body: const EmptyPage(description: 'No Product Item on Sale',),
      body: products.isEmpty
          ? EmptyPage(
              description: widget.isCategoryPage ? 'No Products In This Category' : 'No Search Results',
              type: ConstEmptyPage.ORDER,
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: screenSize.width / (screenSize.height * 0.78),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: List.generate(
                      products.length,
                      (index) => ChangeNotifierProvider.value(
                        value: products[index],
                        child: const ProductItemWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
