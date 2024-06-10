import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/product_provider.dart';

class ProductDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // Remove the shadow if needed
      title: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return Text(
            provider.product?.name ?? 'Product Detail',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
          );
        },
      ),
      iconTheme: IconThemeData(
          color: Colors.black), // Ensure icons are visible on white background
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Handle search button press
          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            // Handle shopping cart button press
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0); // Reduced height
}
