import 'package:auto_route/auto_route.dart'; // Import AutoRoute
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/api/api_url.dart';
import 'package:uju_app/components/product_item.dart';
import 'package:uju_app/providers/app_provider.dart';
import 'package:uju_app/theme/app_theme.dart';
import 'package:uju_app/components/base_screen.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      selectedIndex: 3, // Profile page index
      showHeader: false, // Hide the default header
      body: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.router.pop(); // Navigate back
            },
          ),
          title: Text('Профайл'),
          centerTitle: true, // Center the title
        ),
        body: Consumer<AppProvider>(
          builder: (context, appProvider, child) {
            if (appProvider.loading) {
              return Center(child: CircularProgressIndicator());
            }

            final user = appProvider.userModel;
            final favItems = appProvider.favoriteItems;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username ?? '',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text('Оноо: ${user.userpoint ?? 0}',
                              style: TextStyle(
                                  color: AppTheme.textSecondaryColor)),
                        ],
                      ),
                      Column(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${getBaseURL()}/api/file/download?ID=${user.userImage}',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('리워드 혜택'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('프로필 수정'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  DefaultTabController(
                    length: 1,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: AppTheme.ujuColor,
                          indicatorColor: AppTheme.ujuColor,
                          tabs: [
                            Tab(text: 'Таны хүслийн жагсаалт '),
                          ],
                        ),
                        Container(
                          height: 350,
                          child: TabBarView(
                            children: [
                              favItems.isEmpty
                                  ? Center(child: Text('No favorites yet'))
                                  : GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0.0,
                                        mainAxisSpacing: 0.0,
                                        childAspectRatio: 0.70,
                                      ),
                                      itemCount: favItems.length,
                                      shrinkWrap: true,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final product = favItems[index];
                                        final imageUrl = (product['item']
                                                        ['images'] !=
                                                    null &&
                                                product['item']['images']
                                                    .isNotEmpty)
                                            ? '${getBaseURL()}/api/file/download?ID=${product['item']['images'][0]['id']}&size=180'
                                            : null;

                                        final formattedPrice =
                                            product['item']['price'] != null
                                                ? NumberFormat("#,##0", "en_US")
                                                    .format(product['item']
                                                        ['price']['calcprice'])
                                                : 'N/A';

                                        return ProductItem(
                                          id: product['item']['id'],
                                          imageUrl: imageUrl,
                                          title: product['item']['name'],
                                          price: '$formattedPrice' + '₮',
                                          rating: product['item']
                                                      ['valuationdundaj']
                                                  ?.toString() ??
                                              'N/A',
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
