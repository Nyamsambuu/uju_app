import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uju_app/api/api_url.dart';
import 'package:uju_app/models/product_model.dart';
import 'package:uju_app/widgets/slider_widget.dart';

class ProductDetailBody extends StatelessWidget {
  final ProductModel product;

  ProductDetailBody({required this.product});

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat("#,###").format(product.price);
    final formattedCalcPrice = NumberFormat("#,###").format(product.calcprice);

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
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share_outlined),
                      onPressed: () {
                        ('${getBaseURL()})/product/${product.id}');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 4.0),

                // Valuation Rating
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(Icons.star,
                            color: Colors.orange, size: 14.0);
                      }),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      '(${(product.salecount)})',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 4.0),

                if (product.discount > 0)
                  Row(
                    children: [
                      Text(
                        '${product.discount}%',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '${formattedCalcPrice}₮',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    ],
                  ),
                // Product Price and Discount
                Text(
                  '${formattedPrice}₮',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
