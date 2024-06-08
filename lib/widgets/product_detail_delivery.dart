import 'package:flutter/material.dart';
import 'package:uju_app/models/product_model.dart';

class ProductDetailDelivery extends StatelessWidget {
  final ProductModel product;

  ProductDetailDelivery({required this.product});

  @override
  Widget build(BuildContext context) {
    final double onePercent = product.price * 0.01;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(100.0), // Adjust the width as needed
          1: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              Row(
                children: [
                  Icon(Icons.monetization_on_outlined, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Text(
                    'Оноо',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [
                      TextSpan(
                        text: '${onePercent.toStringAsFixed(0)}P ',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      TextSpan(text: 'оноо цуглуулах'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              SizedBox(height: 16.0), // Spacer between rows
              SizedBox(height: 16.0),
            ],
          ),
          TableRow(
            children: [
              Row(
                children: [
                  Icon(Icons.local_shipping_outlined, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Text(
                    'Хүргэлт',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Хүргэлтийн хөлс 5,000 төгрөг',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Хөдөө орон нутаг руу хүргэх үнэ тусдаа бодогдоно.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
