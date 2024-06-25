import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
              if (wishlistcount != null && salecount != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bookmark_border,
                            color: AppTheme.ujuColor, size: 16),
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
