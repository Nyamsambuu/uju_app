// lib/components/base_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uju_app/components/footer.dart';
import 'package:uju_app/components/header.dart'; // Import the header
import 'package:uju_app/routes/app_router.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final bool showHeader;

  BaseScreen(
      {required this.body,
      required this.selectedIndex,
      this.showHeader = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          showHeader ? Header() : null, // Conditionally use the Header widget
      body: body,
      bottomNavigationBar: Footer(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          if (index == selectedIndex)
            return; // Prevents reloading the same route

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
