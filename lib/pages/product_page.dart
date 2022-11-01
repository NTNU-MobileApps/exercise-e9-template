import 'package:flutter/material.dart';

import '../widgets/size_selector.dart';
import 'shopping_cart_page.dart';

/// Represents the product page
class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product page"),
        actions: [_buildShoppingCartButton(context)],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildProductTitle(),
            _buildImage(),
            const SizeSelector(),
          ],
        ),
      ),
    );
  }

  /// Build the action-button to be shown in the action bar.
  /// On click it takes to the shopping-cart page
  Widget _buildShoppingCartButton(BuildContext context) {
    return Row(
      children: const [
        Text("4"),
        IconButton(
          onPressed: null,
          icon: Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  /// Build the title for the product
  Widget _buildProductTitle() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        "A nice t-shirt",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  /// Build the product image
  Widget _buildImage() {
    return Image.asset(
      "images/tshirt.jpg",
      height: 200,
    );
  }

  /// Navigate to the shopping cart page
  void _showShoppingCartPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ShoppingCartPage(),
    ));
  }
}
