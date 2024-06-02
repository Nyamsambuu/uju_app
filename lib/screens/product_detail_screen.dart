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
        title: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return Text(
              provider.product?.name.toUpperCase() ?? 'Product Detail',
              style: Theme.of(context).textTheme.titleMedium,
            );
          },
        ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Slider without left and right padding
                SliderWidget(imageIds: product.productImages),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.categoryname.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.0),

                      // Valuation Rating
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 24.0),
                          SizedBox(width: 4.0),
                          Text(
                            '${product.valuationdundaj ?? 0.0} (${product.valuationdundaj})',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),

                      // Product Price and Discount
                      Text(
                        '₮${product.price}',
                        style: Theme.of(context).textTheme.headlineMedium,
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

                      // Body Images without left and right padding
                      if (product.bodyImages.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(height: 16.0),
                            Text(
                              'Product Details',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SliderWidget(imageIds: product.bodyImages),
                          ],
                        ),

                      // Other Product Details...
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
