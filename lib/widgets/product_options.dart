// lib/widgets/product_options.dart
import 'package:flutter/material.dart';
import 'package:uju_app/models/product_model.dart';

class ProductOptions extends StatelessWidget {
  final ProductModel product;

  ProductOptions({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Add your product options here
        ],
      ),
    );
  }
}
