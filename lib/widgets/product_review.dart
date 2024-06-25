import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uju_app/api/api_url.dart';
import 'package:uju_app/models/product_model.dart';
import 'package:uju_app/theme/app_theme.dart';
import 'package:uju_app/widgets/product_review_list.dart';

class Review extends StatefulWidget {
  final ProductModel product;

  Review({required this.product});

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool _showAllReviews = false;

  void _showReviewSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: ReviewSheet(product: widget.product),
        );
      },
    );
  }

  void _showReviewList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewListScreen(product: widget.product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Default valuationtoo values to 0 if not provided
    Map<int, int> valuationMap = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var valToo in widget.product.valuationtoo) {
      valuationMap[valToo.rate] = valToo.too;
    }

    int displayReviewsCount =
        _showAllReviews ? widget.product.valuation.length : 3;

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
                      text:
                          '(${widget.product.valuation.length})'.toUpperCase(),
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
                        Text(
                            widget.product.valuationdundaj
                                    ?.toStringAsFixed(1) ??
                                'N/A',
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
        Divider(thickness: 0.25),
        widget.product.valuation.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('Өгсөн үнэлгээ байхгүй байна')),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: displayReviewsCount + (_showAllReviews ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index == displayReviewsCount && !_showAllReviews) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFA541B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 50,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _showReviewList(context);
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Бусад үнэлгээг харах',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' (${widget.product.valuation.length})',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final review = widget.product.valuation[index];
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
              )
      ],
    );
  }
}

class ReviewSheet extends StatefulWidget {
  final ProductModel product;

  ReviewSheet({required this.product});

  @override
  _ReviewSheetState createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  int _selectedStars = 0;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: widget.product.productImages.isNotEmpty &&
                          // ignore: unnecessary_null_comparison
                          widget.product.productImages[0] != null
                      ? Image.network(
                          '${getBaseURL()}/api/file/download?ID=${widget.product.productImages[0]}',
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
                        widget.product.name,
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
          Text(
            'Үнэлгээний оноо',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                    index < _selectedStars ? Icons.star : Icons.star_border,
                    color: index < _selectedStars
                        ? AppTheme.ujuColor
                        : Colors.grey),
                onPressed: () {
                  setState(() {
                    _selectedStars = index + 1;
                  });
                },
              );
            }),
          ),
          SizedBox(height: 16),
          Text('Зураг хавсаргах /заавал биш/'),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.add_a_photo),
            label: Text('Зураг хавсаргах'),
          ),
          if (_imageFile != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Image.file(File(_imageFile!.path)),
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
            onPressed: () {
              int points =
                  _selectedStars; // Use the selected star rating as points
              print('Selected points: $points'); // Example action with points
              // Add your logic to handle the points here, such as sending to an API
              Navigator.pop(context);
            },
            child: Text(
              'ҮНЭЛГЭЭ ӨГӨХ',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.ujuColor,
              minimumSize: Size(double.infinity, 36),
            ),
          ),
        ],
      ),
    );
  }
}
