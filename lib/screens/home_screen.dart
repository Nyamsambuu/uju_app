// lib/screens/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uju_app/components/base_screen.dart';
import '../components/slider.dart';
import '../components/category_list.dart';
import '../components/product_list.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedSortType = 1;

  final List<Map<String, dynamic>> _sortOptions = [
    {'value': 1, 'label': 'Борлуулалтаар'},
    {'value': 2, 'label': 'Хамгийн их таалагдсан'},
    {'value': 3, 'label': 'Хамгийн сүүлд нэмэгдсэн'},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      selectedIndex: 0,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SliderWidget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CategoryList(),
                      ),
                      SizedBox(height: 8),
                      Divider(
                        color: Color(0xFFF8F9FB),
                        thickness: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                spacing: 8.0,
                                children: _sortOptions.map((option) {
                                  return ChoiceChip(
                                    selectedColor: Colors.grey[350],
                                    labelStyle:
                                        Theme.of(context).textTheme.labelSmall,
                                    label: Text(option['label']),
                                    selected:
                                        _selectedSortType == option['value'],
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedSortType = option['value'];
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ProductList(sortType: _selectedSortType),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
