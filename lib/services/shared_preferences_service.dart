import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order_state.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();
  SharedPreferences? _preferences;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  Future<void> setOrderState(OrderState orderState) async {
    String jsonString = jsonEncode(orderState.toJson());
    await _preferences?.setString('orderState', jsonString);
  }

  OrderState? getOrderState() {
    String? jsonString = _preferences?.getString('orderState');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return OrderState.fromJson(jsonMap);
    }
    return null;
  }

  // Methods for login data and token
  Future<void> setLoggedIn(bool loggedIn) async {
    await _preferences?.setBool('loggedIn', loggedIn);
  }

  bool? isLoggedIn() {
    return _preferences?.getBool('loggedIn');
  }

  Future<void> setToken(String token) async {
    await _preferences?.setString('token', token);
  }

  String? getToken() {
    return _preferences?.getString('token');
  }
}
