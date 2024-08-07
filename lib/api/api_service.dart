import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uju_app/models/product_model.dart';

class ApiService {
  static const String baseUrl = 'http://159.223.73.3:8080';

  Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(data);

    try {
      final response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      throw Exception('Failed to make POST request: $e');
    }
  }

  Future<List<dynamic>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/Product/Get_category_Tree?parentid=1'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['retdata'];
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<dynamic>> fetchProducts(int sortType) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/api/Product/get_Item_list?isparent=true&sorttype=$sortType'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['retdata'];
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<dynamic>> fetchSliderImages() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/api/file/get_file_data?sourceID=1&sourceType=ecomslider'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['retdata'];
    } else {
      throw Exception('Failed to load slider images');
    }
  }

  Future<List<dynamic>> fetchTags() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/Product/get_Tag_list'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['retdata'];
    } else {
      throw Exception('Failed to load slider images');
    }
  }

  Future<Map<String, dynamic>> fetchUser(String userid) async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/systems/User/get_user?userid=$userid'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Map<String, dynamic>> getWishlists(String userid) async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/Product/get_wishlists?userid=$userid'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load wishlists');
    }
  }

  Future<Map<String, dynamic>> getShoppingCart(String userid) async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/Product/get_shoppingcart?userid=$userid'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load wishlists');
    }
  }

  Future<ProductModel> fetchProduct(int productid) async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/Product/get_Item?id=$productid'));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to product item');
    }
  }

  Future<dynamic> getReviews(int itemId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/api/Product/get_valuation_list?itemid=$itemId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<void> setFavorite(int itemid, String userid, String token) async {
    final data = [
      {
        'itemid': itemid,
        'userid': userid,
      },
    ];
    final response = await http.post(
      Uri.parse('$baseUrl/api/Product/set_wishlists'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Хүслийн жагсаалтанд нэмэгдлээ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    } else if (response.statusCode != 200) {
      throw Exception('Failed to set favorite: ${response.body}');
    }
  }

  Future<void> removeFavorite(int id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/Product/delete_wishlists?id=$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Хүслийн жагсаалтаас хаслаа',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 12.0,
      );
    } else if (response.statusCode != 200) {
      throw Exception('Failed to remove favorite: ${response.body}');
    }
  }
}
