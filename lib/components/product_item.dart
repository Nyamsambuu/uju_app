import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/app_provider.dart';
import 'package:uju_app/routes/app_router.dart';
import 'package:uju_app/theme/app_theme.dart';

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
        context.router.push(ProductDetailRoute(productId: id));
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
                    bottom: -8,
                    right: -6,
                    child: IconButton(
                      icon: isFavorite
                          ? Transform.scale(
                              scaleX: 1.2, // Scale the width by 1.5 times
                              child: Icon(
                                Icons.bookmark,
                                color: AppTheme.ujuColor,
                                size: 26.0,
                              ),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Transform.scale(
                                  scaleX: 1.2, // Scale the width by 1.5 times
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 25.5,
                                  ),
                                ),
                                Transform.scale(
                                  scaleX: 1.2, // Scale the width by 1.5 times
                                  child: Icon(
                                    Icons.bookmark_border,
                                    color: Color(0xFFFAFAFA),
                                    size: 25.5,
                                  ),
                                ),
                              ],
                            ),
                      onPressed: () async {
                        if (!appProvider.isLoggedIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Та нэвтрэх хэрэгтэй байна.'),
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
              if (wishlistcount != null && salecount != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shopping_bag,
                            color: AppTheme.ujuColor.withOpacity(0.8),
                            size: 16),
                        SizedBox(width: 4),
                        Text(
                          wishlistcount != null
                              ? wishlistcount.toString()
                              : '0',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Icon(Icons.bookmark, color: Colors.grey[600], size: 16),
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
