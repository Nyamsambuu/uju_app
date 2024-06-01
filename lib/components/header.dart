import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uju_app/routes/app_router.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
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
                  suffixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.bookmark_border, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}
