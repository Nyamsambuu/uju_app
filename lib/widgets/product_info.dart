import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uju_app/api/api_url.dart';

class ProductInfo extends StatefulWidget {
  final List<String> bodyImages;

  ProductInfo({required this.bodyImages});

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  bool _expanded = false;

  Future<void> _fetchImage(String url) async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 20)); // Increased timeout duration
      if (response.statusCode == 200) {
        print('Image fetched successfully');
      } else {
        print('Failed to load image: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Timeout fetching image: $e');
    } catch (e) {
      print('Error fetching image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _expanded ? null : 500.0,
            child: SingleChildScrollView(
              physics: _expanded ? NeverScrollableScrollPhysics() : null,
              child: Column(
                children: widget.bodyImages.map((imageId) {
                  final imageUrl =
                      '${getBaseURL()}/api/file/download?ID=$imageId';

                  _fetchImage(imageUrl);

                  return Container(
                    width: double.infinity,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Center(
                          child: Text('Failed to load image'),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          if (!_expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Colors.white.withOpacity(0.5), width: 2),
                    right: BorderSide(
                        color: Colors.white.withOpacity(0.5), width: 2),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFA541B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  child: Center(
                    child: TextButton(
                      iconAlignment: IconAlignment.start,
                      onPressed: () {
                        setState(() {
                          _expanded = true;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Дэлгэрэнгүй харах',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                              width:
                                  8), // Add some space between the text and the icon
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
