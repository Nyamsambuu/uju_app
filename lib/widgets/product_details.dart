import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/product_provider.dart';
import 'package:uju_app/widgets/slider_widget.dart';

@RoutePage()
class ProductDetailScreen extends StatelessWidget {
  final int productId;

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    // Fetch product details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .fetchProduct(productId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.product == null) {
            return Center(child: Text('Failed to load product'));
          }

          final product = provider.product!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Slider
                SliderWidget(imageIds: product.productImages),

                SizedBox(height: 16.0),

                // Product Title
                Text(
                  product.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 16.0),

                // Product Price and Discount
                Text(
                  '₮${product.price}', // Replace with actual price
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                if (product.discount > 0)
                  Row(
                    children: [
                      Text(
                        '₮${product.price + product.discount}',
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '${product.discount}% OFF',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  ),

                // Body Images
                if (product.bodyImages.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(height: 16.0),
                      Text(
                        'Product Details',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SliderWidget(imageIds: product.bodyImages),
                    ],
                  ),

                // Other Product Details...
              ],
            ),
          );
        },
      ),
    );
  }
}
