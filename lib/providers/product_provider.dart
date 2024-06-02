import 'package:flutter/material.dart';
import 'package:uju_app/models/product_model.dart';
import 'package:uju_app/api/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  ProductModel? _product;
  bool _loading = false;

  ProductModel? get product => _product;
  bool get loading => _loading;

  Future<void> fetchProduct(int productId) async {
    _loading = true;
    notifyListeners();
    try {
      _product = await _apiService.fetchProduct(productId);
      print('Product fetched: $_product'); // Debug print statement
    } catch (error) {
      print('Error fetching product: $error'); // Debug print statement
      // Handle error
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
