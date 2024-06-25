import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/app_provider.dart';
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
                        : null;

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
  final String? imageUrl;
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
    final appProvider = Provider.of<AppProvider>(context);
    final favoriteItem = appProvider.favoriteItems
        .firstWhere((item) => item['itemid'] == id, orElse: () => null);
    final isFavorite = favoriteItem != null;

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
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  child: Center(
                                    child: Text(
                                      'Зураггүй',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Colors.grey,
                              child: Center(
                                child: Text(
                                  'Зураггүй',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  if (discount != null)
                    Positioned(
                      top: -10,
                      left: -10,
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
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                      icon: isFavorite
                          ? Icon(
                              Icons.bookmark,
                              color: AppTheme.ujuColor,
                              size: 28.0,
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.bookmark,
                                  color: Colors.white.withOpacity(0.5),
                                  size: 28.0,
                                ),
                                Icon(
                                  Icons.bookmark_border,
                                  color: Color(0xFFFAFAFA),
                                  size: 28.0,
                                ),
                              ],
                            ),
                      onPressed: () async {
                        if (!appProvider.isLoggedIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Та нэвтрэх хэрэгтэй'),
                            ),
                          );
                          return;
                        }

                        if (isFavorite) {
                          await appProvider.removeFavorite(favoriteItem['id']);
                        } else {
                          await appProvider.setFavorite(id);
                        }

                        if (appProvider.error.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(appProvider.error),
                            ),
                          );
                        }
                      },
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
