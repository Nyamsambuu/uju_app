// lib/components/drawer_content.dart
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../api/api_url.dart';

class DrawerContent extends StatelessWidget {
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
            color: Colors.white, // Set background color to white
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                final imageUrl = category['images'] != null &&
                        category['images'].isNotEmpty
                    ? '${getBaseURL()}/api/file/download?ID=${category['images'][0]}'
                    : null;
                return ListTile(
                  leading: imageUrl != null
                      ? Image.network(imageUrl, width: 40, height: 40)
                      : null,
                  title: Text(category['name']),
                  onTap: () {
                    // Handle category tap
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
