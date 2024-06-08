import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uju_app/models/product_model.dart';
import 'package:uju_app/theme/app_theme.dart';

class Review extends StatelessWidget {
  final ProductModel product;

  Review({required this.product});

  @override
  Widget build(BuildContext context) {
    // Default valuationtoo values to 0 if not provided
    Map<int, int> valuationMap = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var valToo in product.valuationtoo) {
      valuationMap[valToo.rate] = valToo.too;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text('Үнэлгээ'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge),
              Spacer(),
              Text(
                'ҮНЭЛГЭЭ ӨГӨХ',
                style: TextStyle(
                    color: AppTheme.ujuColor, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
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
                        Text(product.valuationdundaj.toString(),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        Divider(
          thickness: 0.3,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: product.valuation.length,
          itemBuilder: (context, index) {
            final review = product.valuation[index];
            final formattedDate =
                DateFormat('yyyy/MM/dd HH:mm').format(review.updated);

            // Generate stars based on the rating
            List<Widget> stars = List.generate(5, (i) {
              if (i < review.rate) {
                return Icon(Icons.star, color: AppTheme.ujuColor, size: 16);
              } else {
                return Icon(Icons.star, color: Colors.grey, size: 16);
              }
            });

            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundColor: AppTheme
                        .ujuColor, // Replace with desired background color
                    child: Text(
                      review.username[0]
                          .toUpperCase(), // Use the first letter of the username
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
                Divider(
                  thickness: 0.3,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
