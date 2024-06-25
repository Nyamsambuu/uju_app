import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/product_provider.dart';
import 'package:uju_app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class ProductOptionsBottomSheet extends StatefulWidget {
  final int productId;

  ProductOptionsBottomSheet({required this.productId});

  @override
  _ProductOptionsBottomSheetState createState() =>
      _ProductOptionsBottomSheetState();
}

class _ProductOptionsBottomSheetState extends State<ProductOptionsBottomSheet> {
  final List<Map<String, dynamic>> selectedProducts = [];
  final NumberFormat _nf = NumberFormat('#,###');
  String? selectedChildId;
  double _bottomSheetHeight = 284;
  final GlobalKey _contentKey = GlobalKey();

  void _updateHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_contentKey.currentContext != null) {
        final RenderBox renderBox =
            _contentKey.currentContext!.findRenderObject() as RenderBox;
        final size = renderBox.size;
        setState(() {
          _bottomSheetHeight = size.height + 32; // Add padding
        });
      }
    });
  }

  void _showCustomSnackbar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).padding.top + 16.0,
        left: 16.0,
        right: 16.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

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
        _updateHeight();

        return LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _bottomSheetHeight,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                        child: Column(
                          key: _contentKey,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatefulBuilder(
                              builder: (context, setState) {
                                return DropdownButtonFormField<String>(
                                  iconEnabledColor: AppTheme.ujuColor,
                                  dropdownColor: Colors.white,
                                  decoration: InputDecoration(
                                      labelText: 'Барааны сонголт',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.ujuColor,
                                          width: 1,
                                        ),
                                      ),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start),
                                  alignment: Alignment.topCenter,
                                  value: selectedChildId,
                                  items: product.children
                                      .map<DropdownMenuItem<String>>((child) {
                                    return DropdownMenuItem<String>(
                                      value: child.id.toString(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${child.itemtype} '),
                                          Text(
                                            '${_nf.format(child.unitprice)}₮',
                                            style: TextStyle(
                                              color: AppTheme.ujuColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      final selectedChild = product.children
                                          .firstWhere((child) =>
                                              child.id.toString() == value);
                                      if (!selectedProducts.any((product) =>
                                          product['id'] == selectedChild.id)) {
                                        selectedProducts.add({
                                          'id': selectedChild.id,
                                          'itemtype': selectedChild.itemtype,
                                          'unitprice': selectedChild.unitprice,
                                          'quantity': 1
                                        });
                                      } else {
                                        _showCustomSnackbar(context,
                                            'Энэ бараа нэмэгдсэн байна');
                                      }
                                      selectedChildId = null;
                                    });
                                    _updateHeight();
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 16),
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight *
                                    0.51, // Max height for product list
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: selectedProducts.map((product) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          color: AppTheme.bgColor,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  ListTile(
                                                    title: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            product['itemtype'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    subtitle: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Container(
                                                            height: 33,
                                                            color: Colors.white,
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  IconButton(
                                                                    icon: Icon(Icons
                                                                        .remove),
                                                                    iconSize:
                                                                        20,
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        if (product['quantity'] >
                                                                            1) {
                                                                          product[
                                                                              'quantity']--;
                                                                        }
                                                                      });
                                                                      _updateHeight();
                                                                    },
                                                                  ),
                                                                  Text(
                                                                    product['quantity']
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleLarge,
                                                                  ),
                                                                  IconButton(
                                                                    icon: Icon(
                                                                        Icons
                                                                            .add),
                                                                    iconSize:
                                                                        20,
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        product[
                                                                            'quantity']++;
                                                                      });
                                                                      _updateHeight();
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          '${_nf.format(product['unitprice'])}₮',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: -5,
                                                    top: -5,
                                                    child: IconButton(
                                                      icon: Icon(Icons.close),
                                                      color: Colors.grey,
                                                      iconSize: 18,
                                                      onPressed: () {
                                                        setState(() {
                                                          selectedProducts
                                                              .remove(product);
                                                          _updateHeight();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'НИЙТ ДҮН',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${_nf.format(selectedProducts.fold<int>(0, (previousValue, product) => previousValue + ((product['unitprice'] as num).toInt() * (product['quantity'] as num).toInt())))}₮',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
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
                                child: Text('Болих'),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle direct purchase
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.ujuColor,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text('Худалдан авах'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
