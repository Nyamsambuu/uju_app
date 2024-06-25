// lib/components/base_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/components/footer.dart';
import 'package:uju_app/providers/app_provider.dart';
import 'package:uju_app/routes/app_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:uju_app/theme/app_theme.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final int selectedIndex;

  BaseScreen({required this.body, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            context.router.push(MenuCategoriesRoute());
          },
        ),
        title: Row(
          children: [
            SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Бараа хайх',
                    hintStyle: TextStyle(
                      color: Colors.grey, // Change the color
                      fontSize: 14, // Change the font size
                      fontWeight: FontWeight.w400, // Change the font weight
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    suffixIcon:
                        Icon(Icons.search, color: AppTheme.primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          appProvider.favoriteItems.length != 0
              ? badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 0, end: 3),
                  badgeContent: Text(
                    appProvider.favoriteItems.length.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.bookmark_border, color: Colors.black),
                    onPressed: () {},
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.bookmark_border, color: Colors.black),
                  onPressed: () {},
                ),
          appProvider.shoppingCart.length != 0
              ? badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 0, end: 3),
                  badgeContent: Text(
                    appProvider.shoppingCart.length.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  child: IconButton(
                    icon:
                        Icon(Icons.shopping_cart_outlined, color: Colors.black),
                    onPressed: () {},
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
                  onPressed: () {},
                )
        ],
      ),
      body: body,
      bottomNavigationBar: Footer(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              context.router.push(HomeRoute());
              break;
            case 1:
              context.router.push(SearchRoute());
              break;
            case 2:
              context.router.push(OrdersRoute());
              break;
            case 3:
              context.router.push(ProfileRoute());
              break;
          }
        },
      ),
    );
  }
}
