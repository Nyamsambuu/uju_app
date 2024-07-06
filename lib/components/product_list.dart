import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../api/api_service.dart';
import '../api/api_url.dart';
import 'product_item.dart'; // Import the ProductItem widget

class ProductList extends StatelessWidget {
  final ApiService apiService = ApiService();
  final int sortType;

  ProductList({required this.sortType});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: apiService.fetchProducts(sortType),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoading(); // Display skeleton loading
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    final imageUrl = (product['images'] != null &&
                            product['images'].isNotEmpty)
                        ? '${getBaseURL()}/api/file/download?ID=${product['images'][0]['id']}&size=180'
                        : null;

                    final formattedPrice = NumberFormat("#,##0", "en_US")
                        .format(product['price']['calcprice']);

                    return ProductItem(
                      id: product['id'],
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

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            itemCount: 6, // Number of skeleton items to show
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 16,
                        width: 100,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            height: 16,
                            width: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 16,
                            width: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
