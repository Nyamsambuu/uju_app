// lib/components/category_list.dart
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../api/api_url.dart';

class CategoryList extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: apiService.fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length + 1, // +1 for "Бүх ангилал"
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CategoryItem(
                    title: 'Бүх ангилал',
                    imageUrl: null,
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icons.menu,
                  );
                } else {
                  final category = snapshot.data![index - 1];
                  final imageUrl = category['images'] != null &&
                          category['images'].isNotEmpty
                      ? '${getBaseURL()}/api/file/download?ID=${category['images'][0]}'
                      : null;
                  return CategoryItem(
                    title: category['name'],
                    imageUrl: imageUrl,
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final VoidCallback? onTap;
  final IconData? icon;

  CategoryItem({required this.title, this.imageUrl, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80, // Adjust the width as needed
        child: Column(
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )
            else if (icon != null)
              Icon(
                icon,
                size: 40,
                color: Colors.black,
              ),
            SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.1),
            ),
          ],
        ),
      ),
    );
  }
}
