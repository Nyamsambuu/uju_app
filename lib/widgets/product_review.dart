import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uju_app/api/api_url.dart';
import 'package:uju_app/models/product_model.dart';
import 'package:uju_app/theme/app_theme.dart';

class Review extends StatelessWidget {
  final ProductModel product;

  Review({required this.product});

  void _showReviewSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(),
                    Text(
                      'ҮНЭЛГЭЭ ӨГӨХ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: product.productImages.isNotEmpty &&
                                product.productImages[0] != null
                            ? Image.network(
                                '${getBaseURL()}/api/file/download?ID=${product.productImages[0]}',
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              )
                            : Image.asset(
                                'assets/placeholder.png', // Path to your placeholder image
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text('250P оноо /зураг хавсаргавал/',
                                style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text('Үнэлгээний оноо'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(Icons.star_border),
                      onPressed: () {},
                    );
                  }),
                ),
                SizedBox(height: 16),
                Text('Зураг хавсаргах /заавал биш/'),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_a_photo),
                  label: Text('Зураг хавсаргах'),
                ),
                SizedBox(height: 16),
                Text('Сэтгэгдэл'),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText:
                        'Энэ бүтээгдэхүүнийг хэрэглэх явцад ямар давуу болон сул талуудыг мэдэрсэн талаар илэн далангүй бичээрэй.',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('리뷰 등록'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.ujuColor,
                    minimumSize: Size(double.infinity, 36),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(text: 'Үнэлгээ '.toUpperCase()),
                    TextSpan(
                      text: '(${product.valuationtoo.length})'.toUpperCase(),
                      style: TextStyle(color: AppTheme.ujuColor).copyWith(
                          fontWeight:
                              FontWeight.bold), // Set the desired color here
                    ),
                    TextSpan(text: ' '),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _showReviewSheet(context),
                child: Text(
                  'ҮНЭЛГЭЭ ӨГӨХ',
                  style: TextStyle(
                      color: AppTheme.ujuColor, fontWeight: FontWeight.w400),
                ),
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
