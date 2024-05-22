import 'dart:convert';
import 'api_service.dart';

class AuthApi {
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await apiService.postRequest('Systems/login', {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw Exception('Failed to decode JSON response: $e');
      }
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
