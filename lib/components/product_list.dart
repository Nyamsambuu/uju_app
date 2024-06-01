import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api/api_service.dart';
import '../api/api_url.dart';

class ProductList extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: apiService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available'));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: snapshot.data!.length,
                  shrinkWrap:
                      true, // Ensures the GridView takes up only the necessary space
                  physics:
                      NeverScrollableScrollPhysics(), // Prevents the GridView from scrolling
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    final imageUrl = (product['images'] != null &&
                            product['images'].isNotEmpty)
                        ? '${getBaseURL()}/api/file/download?ID=${product['images'][0]['id']}&size=180'
                        : 'https://via.placeholder.com/100';

                    final formattedPrice = NumberFormat("#,##0", "en_US")
                        .format(product['price']['calcprice']);
                    return ProductItem(
                      imageUrl: imageUrl,
                      title: product['name'],
                      price: '$formattedPrice₮',
                      rating: '${product['rating']}',
                      discount: product['discount'] != null
                          ? '${product['discount']}%'
                          : null,
                      wishlistcount: product['wishlistcount'],
                      salecount: product['salecount'],
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String rating;
  final String? discount;
  final int? wishlistcount;
  final int? salecount;

  ProductItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    this.discount,
    this.wishlistcount,
    this.salecount,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 350, // Adjust the max height as needed
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (discount != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      color: Colors.red,
                      child: Text(
                        discount!,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 2,
                  right: 0,
                  child: Icon(Icons.bookmark_border, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2),
            Text(
              price,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bookmark_border, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text(
                      wishlistcount != null ? wishlistcount.toString() : '0',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(Icons.sell_outlined, color: Colors.orange, size: 16),
                    SizedBox(width: 2),
                    Text(
                      salecount != null ? salecount.toString() : '0',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
