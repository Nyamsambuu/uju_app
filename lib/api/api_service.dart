import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/api/Product/get_Item_list?isparent=true&sorttype=1'));
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
}
