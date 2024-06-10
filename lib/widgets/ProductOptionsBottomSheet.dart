import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/product_provider.dart';
import 'package:uju_app/models/product_model.dart';

class ProductOptionsBottomSheet extends StatefulWidget {
  final int productId;

  ProductOptionsBottomSheet({required this.productId});

  @override
  _ProductOptionsBottomSheetState createState() =>
      _ProductOptionsBottomSheetState();
}

class _ProductOptionsBottomSheetState extends State<ProductOptionsBottomSheet> {
  final List<Map<String, dynamic>> selectedProducts = [];
  String? selectedChildId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (productProvider.product == null) {
          return Center(child: Text('Failed to load product options'));
        }

        final product = productProvider.product!;
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Барааны сонголт',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: OutlineInputBorder(),
                      ),
                      items: product.children
                          .map<DropdownMenuItem<String>>((child) {
                        return DropdownMenuItem<String>(
                          value: child.id.toString(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(child.itemtype),
                              Text('${child.unitprice}₮'),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedChildId = value;
                          final selectedChild = product.children.firstWhere(
                              (child) => child.id.toString() == value);
                          selectedProducts.add({
                            'id': selectedChild.id,
                            'itemtype': selectedChild.itemtype,
                            'unitprice': selectedChild.unitprice,
                            'quantity': 1
                          });
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    ...selectedProducts.map((product) {
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product['itemtype']),
                                Text('₮${product['unitprice']}'),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (product['quantity'] > 1) {
                                        product['quantity']--;
                                      }
                                    });
                                  },
                                ),
                                Text(product['quantity'].toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      product['quantity']++;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      selectedProducts.remove(product);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1),
                        ],
                      );
                    }).toList(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '주문 금액',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₩${selectedProducts.fold<int>(0, (previousValue, product) => previousValue + ((product['unitprice'] as num).toInt() * (product['quantity'] as num).toInt()))}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle coupon reception
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                        foregroundColor: Colors.red,
                      ),
                      child: Text('쿠폰 받기'),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle adding to cart
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              foregroundColor: Colors.black,
                            ),
                            child: Text('장바구니'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle direct purchase
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('바로구매'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
