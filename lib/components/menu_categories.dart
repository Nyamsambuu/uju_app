// lib/components/menu_categories.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:uju_app/routes/app_router.dart';
import '../api/api_service.dart';
import '../api/api_url.dart';

@RoutePage()
class MenuCategories extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Бүх ангилал'.toUpperCase()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.router.push(HomeRoute());
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            bool showMoreButton = snapshot.data!.length > 8;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Сүүлийн хайлт'.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            '#Чанель',
                            style: TextStyle(
                              fontSize: 12, // Adjust the font size
                            ),
                          ),
                          avatar: Icon(
                            Icons.search,
                            size: 16, // Adjust the icon size
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical:
                                  1.0), // Adjust the padding inside the Chip
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Shrinks the tap target size
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'БАРААНЫ АНГИЛАЛ'.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          final category = snapshot.data![index];
                          final imageUrl = category['images'] != null &&
                                  category['images'].isNotEmpty
                              ? '${getBaseURL()}/api/file/download?ID=${category['images'][0]}'
                              : null;
                          return Column(
                            children: [
                              if (imageUrl != null)
                                Image.network(
                                  imageUrl,
                                  height: 45,
                                ),
                              SizedBox(height: 4),
                              Text(
                                category['name'].toString(),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    if (showMoreButton)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Дэлгэрэнгүй',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    Divider(
                      color: Color(0xFFF0f0f0),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<List<dynamic>>(
                      future: apiService.fetchTags(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 0.1,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final tag = snapshot.data![index];
                              final imageUrl = tag['image'] != null
                                  ? '${getBaseURL()}/api/file/download?ID=${tag['image']}'
                                  : null;
                              return Column(
                                children: [
                                  Card(
                                    child: imageUrl != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Adjust the radius as needed
                                            child: Image.network(
                                              imageUrl,
                                              height: 45,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : SizedBox(
                                            height: 40,
                                          ), // Placeholder size if no image
                                  ),
                                  SizedBox(height: 4),
                                  Text(tag['name'],
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle logout logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFA541B),
            foregroundColor: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout), // Add your icon here
              SizedBox(
                  width: 8), // Add some space between the icon and the text
              Text('ГАРАХ'),
            ],
          ),
        ),
      ),
    );
  }
}
