// lib/screens/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uju_app/routes/app_router.dart';
import '../components/header.dart';
import '../components/slider.dart';
import '../components/category_list.dart';
import '../components/product_list.dart';
import '../components/drawer_content.dart';
import '../components/footer.dart'; // Import the Footer widget

@RoutePage()
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Header(),
      ),
      drawer: Drawer(
        child: DrawerContent(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SliderWidget(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16),
                        CategoryList(),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Эрэлттэй Бараа'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Борлуулалтаар',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ProductList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        selectedIndex: 0, // Set the appropriate selected index
        onItemTapped: (index) {
          // Handle item tap and navigation
          switch (index) {
            case 0:
              context.router.replace(HomeRoute());
              break;
            case 1:
              context.router.replace(SearchRoute());
              break;
            case 2:
              context.router.replace(OrdersRoute());
              break;
            case 3:
              context.router.replace(ProfileRoute());
              break;
          }
        },
      ),
    );
  }
}
