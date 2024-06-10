import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uju_app/models/product_model.dart';
import 'package:uju_app/theme/app_theme.dart';

class ReviewListScreen extends StatelessWidget {
  final ProductModel product;

  ReviewListScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    // Default valuationtoo values to 0 if not provided
    Map<int, int> valuationMap = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var valToo in product.valuationtoo) {
      valuationMap[valToo.rate] = valToo.too;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Үнэлгээ (${product.valuation.length})',
            style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.bgColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Text(product.valuationdundaj!.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.headlineLarge),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Center the stars
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: AppTheme.ujuColor,
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [5, 4, 3, 2, 1].map((rate) {
                            int too = valuationMap[rate] ?? 0;
                            return Row(
                              children: [
                                Text('$rate оноо'),
                                SizedBox(width: 8),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: too /
                                        10.0, // Adjust the value range as needed
                                    backgroundColor: Colors.grey[300],
                                    color: AppTheme.ujuColor,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('$too'),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(thickness: 0.1),
          Expanded(
            child: ListView.builder(
              itemCount: product.valuation.length,
              itemBuilder: (context, index) {
                final review = product.valuation[index];
                final formattedDate =
                    DateFormat('yyyy/MM/dd HH:mm').format(review.updated);

                List<Widget> stars = List.generate(review.rate, (i) {
                  return Icon(Icons.star, color: AppTheme.ujuColor, size: 12);
                });

                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppTheme.ujuColor,
                        child: Text(
                          review.username[0].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(review.username,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ...stars,
                              SizedBox(width: 5),
                              Text('$formattedDate'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text('${review.comment}'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
