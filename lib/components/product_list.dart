import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uju_app/routes/app_router.dart';
import 'package:uju_app/theme/app_theme.dart';
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    final imageUrl = (product['images'] != null &&
                            product['images'].isNotEmpty)
                        ? '${getBaseURL()}/api/file/download?ID=${product['images'][0]['id']}&size=180'
                        : 'https://via.placeholder.com/100';

                    final formattedPrice = NumberFormat("#,##0", "en_US")
                        .format(product['price']['calcprice']);
                    return ProductItem(
                      id: product['id'],
                      imageUrl: imageUrl,
                      title: product['name'],
                      price: '$formattedPrice' + '₮',
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
  final int id;
  final String imageUrl;
  final String title;
  final String price;
  final String rating;
  final String? discount;
  final int? wishlistcount;
  final int? salecount;

  ProductItem({
    required this.id,
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
    return GestureDetector(
      onTap: () {
        context.router.push(ProductDetailScreenRoute(productId: id));
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 350,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Colors.white.withOpacity(0.5),
                          size: 28.0,
                        ),
                        Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                          size: 28.0,
                        ),
                      ],
                    ),
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
                      Icon(Icons.bookmark_border,
                          color: AppTheme.ujuColor, size: 16),
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
                      Icon(Icons.sell_outlined,
                          color: AppTheme.ujuColor, size: 16),
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
      ),
    );
  }
}
