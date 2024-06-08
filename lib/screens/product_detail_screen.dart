import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/product_provider.dart';
import 'package:uju_app/widgets/product_detail_appbar.dart';
import 'package:uju_app/widgets/product_detail_body.dart';
import 'package:uju_app/widgets/product_detail_delivery.dart';
import 'package:uju_app/widgets/product_detail_info.dart';
import 'package:uju_app/widgets/product_info.dart';
import 'package:uju_app/widgets/product_review.dart';

@RoutePage()
class ProductDetailScreen extends StatefulWidget {
  final int productId;

  ProductDetailScreen({required this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey container1Key = GlobalKey();
  final GlobalKey container2Key = GlobalKey();
  final GlobalKey container3Key = GlobalKey();
  final GlobalKey container4Key = GlobalKey();

  String _currentSection = 'Барааны мэдээлэл';

  void _scrollToContainer(GlobalKey key,
      {double offset = 0.0, double topOffset = 0.0}) {
    // Adding a delay to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (key.currentContext != null) {
        final RenderBox renderBox =
            key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final targetOffset = position.dy + offset - topOffset;

        _scrollController.animateTo(
          _scrollController.offset + targetOffset,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _handleTabSelection(String section) {
    const double topOffset = 160.0; // Adjust this value as needed

    switch (section) {
      case 'Барааны мэдээлэл':
        _scrollToContainer(container1Key, topOffset: topOffset);
        break;
      case 'Хэрэглэгчийн үнэлгээ':
        _scrollToContainer(container2Key, topOffset: topOffset);
        break;
      case 'Хүргэлт / Буцаан олголт':
        _scrollToContainer(container3Key, topOffset: topOffset);
        break;
      case 'Санал болгох бараа':
        _scrollToContainer(container4Key, topOffset: topOffset);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .fetchProduct(widget.productId);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _checkSectionVisibility();
  }

  void _checkSectionVisibility() {
    if (isKeyVisible(container1Key)) {
      _setActiveTab('Барааны мэдээлэл');
    } else if (isKeyVisible(container2Key)) {
      _setActiveTab('Хэрэглэгчийн үнэлгээ');
    } else if (isKeyVisible(container3Key)) {
      _setActiveTab('Хүргэлт / Буцаан олголт');
    } else if (isKeyVisible(container4Key)) {
      _setActiveTab('Санал болгох бараа');
    }
  }

  bool isKeyVisible(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.attached) {
      final position = renderBox.localToGlobal(Offset.zero);
      return position.dy < MediaQuery.of(context).size.height &&
          position.dy + renderBox.size.height > 0;
    }
    return false;
  }

  void _setActiveTab(String section) {
    if (_currentSection != section) {
      setState(() {
        _currentSection = section;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductDetailAppBar(),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.product == null) {
            return Center(child: Text('Failed to load product'));
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    ProductDetailBody(product: provider.product!),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.1,
                    ),
                    ProductDetailDelivery(product: provider.product!),
                    Divider(
                      color: Color(0xFFF3F2F0),
                      thickness: 10,
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: Container(
                    color: Colors.white,
                    child: ProductDetailInfo(
                      product: provider.product!,
                      currentSection: _currentSection,
                      scrollToContainers: {
                        'Барааны мэдээлэл': () =>
                            _handleTabSelection('Барааны мэдээлэл'),
                        'Хэрэглэгчийн үнэлгээ': () =>
                            _handleTabSelection('Хэрэглэгчийн үнэлгээ'),
                        'Хүргэлт / Буцаан олголт': () =>
                            _handleTabSelection('Хүргэлт / Буцаан олголт'),
                        'Санал болгох бараа': () =>
                            _handleTabSelection('Санал болгох бараа'),
                      },
                    ),
                  ),
                  onTabSelected: _setActiveTab,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      key: container1Key,
                      width: double.infinity,
                      color: Colors.white,
                      child:
                          ProductInfo(bodyImages: provider.product!.bodyImages),
                    ),
                    SizedBox(height: 16),
                    Container(
                      key: container2Key,
                      height: 1000.0,
                      width: double.infinity,
                      color: Colors.white,
                      child: Review(),
                    ),
                    SizedBox(height: 16),
                    Container(
                      key: container3Key,
                      height: 1000.0,
                      width: double.infinity,
                      color: Colors.green,
                      child: Center(
                        child: Text('Container 3'),
                      ),
                    ),
                    Container(
                      key: container4Key,
                      height: 1000.0,
                      width: double.infinity,
                      color: Colors.yellow,
                      child: Center(
                        child: Text('Container 4'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 55,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFA541B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Handle purchase button press
                  },
                  child: Text(
                    'Худалдаж авах',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Function(String) onTabSelected;

  _SliverAppBarDelegate({required this.child, required this.onTabSelected});

  @override
  double get minExtent => kToolbarHeight;
  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: () => onTabSelected('Барааны мэдээлэл'),
      child: SizedBox.expand(child: child),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
