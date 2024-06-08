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
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        print('Image fetched successfully');
      } else {
        print('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          Container(
            height: 50,
            color: Colors.black54,
            child: Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _expanded = true;
                  });
                },
                child: Text(
                  'Show More',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
