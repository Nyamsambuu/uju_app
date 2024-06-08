import 'package:flutter/material.dart';
import 'package:uju_app/models/product_model.dart';
import 'package:uju_app/widgets/product_info.dart';

class ProductDetailInfo extends StatefulWidget {
  final ProductModel product;
  final String currentSection;
  final Map<String, VoidCallback> scrollToContainers;

  ProductDetailInfo(
      {required this.product,
      required this.currentSection,
      required this.scrollToContainers});

  @override
  _ProductDetailInfoState createState() => _ProductDetailInfoState();
}

class _ProductDetailInfoState extends State<ProductDetailInfo> {
  final GlobalKey _productInfoKey = GlobalKey();
  final GlobalKey _userReviewsKey = GlobalKey();
  final GlobalKey _shippingReturnsKey = GlobalKey();
  final GlobalKey _recommendedProductsKey = GlobalKey();

  void _scrollToSection(String label) {
    widget.scrollToContainers[label]!();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTabButton(
                  context: context,
                  label: 'Барааны мэдээлэл',
                  key: _productInfoKey,
                ),
                _buildTabButton(
                  context: context,
                  label: 'Хэрэглэгчийн үнэлгээ',
                  key: _userReviewsKey,
                ),
                _buildTabButton(
                  context: context,
                  label: 'Хүргэлт / Буцаан олголт',
                  key: _shippingReturnsKey,
                ),
                _buildTabButton(
                  context: context,
                  label: 'Санал болгох бараа',
                  key: _recommendedProductsKey,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  _productInfoKey,
                  'Барааны мэдээлэл',
                  ProductInfo(bodyImages: widget.product.bodyImages),
                ),
                _buildSection(
                  _userReviewsKey,
                  'Хэрэглэгчийн үнэлгээ',
                  Center(child: Text('Хэрэглэгчийн үнэлгээ')),
                ),
                _buildSection(
                  _shippingReturnsKey,
                  'Хүргэлт / Буцаан олголт',
                  Center(child: Text('Хүргэлт / Буцаан олголт')),
                ),
                _buildSection(
                  _recommendedProductsKey,
                  'Санал болгох бараа',
                  Center(child: Text('Санал болгох бараа')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton({
    required BuildContext context,
    required String label,
    required GlobalKey key,
  }) {
    bool isSelected = widget.currentSection == label;
    return Container(
      height: 56,
      constraints: BoxConstraints(maxWidth: 100),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Color(0xFFFA541B) : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => _scrollToSection(label),
        child: Text(
          label,
          softWrap: true,
          maxLines: 3,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSelected ? Color(0xFFFA541B) : Color(0xFF666666),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
      ),
    );
  }

  Widget _buildSection(GlobalKey key, String title, Widget content) {
    return Container(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          SizedBox(height: 8.0),
          content,
        ],
      ),
    );
  }
}
