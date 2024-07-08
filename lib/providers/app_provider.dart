import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:uju_app/api/api_url.dart';
import 'package:uju_app/models/user_model.dart';
import 'package:uju_app/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppProvider with ChangeNotifier {
  UserModel _userModel = UserModel(
    userid: '',
    userImage: '',
    userpoint: 0,
    email: null,
    username: null,
    gender: null,
    birthday: null,
  );
  List<dynamic> _shoppingCart = [];
  List<dynamic> _favoriteItems = [];
  List<dynamic> _reviews = [];
  bool _loading = false;
  bool _saving = false;
  bool _finished = false;
  String _error = '';
  String _token = '';
  OrderState _orderState = OrderState(
    id: 0,
    orderdate: '',
    status: 0,
    totalprice: 0.0,
    userAddress: UserAddress(id: 0),
    orderDetails: [],
  );

  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  UserModel get userModel => _userModel;
  List<dynamic> get shoppingCart => _shoppingCart;
  List<dynamic> get favoriteItems => _favoriteItems;
  List<dynamic> get reviews => _reviews;
  bool get loading => _loading;
  bool get saving => _saving;
  bool get finished => _finished;
  String get error => _error;
  String get token => _token;
  OrderState get orderState => _orderState;

  AppProvider() {
    initialize();
  }

  Future<void> initialize() async {
    _token = await fetchToken() ?? '';
    _userModel = await fetchUserModel() ??
        UserModel(userid: _userModel.userid, userImage: '', userpoint: 0);

    if (_userModel.userid.isNotEmpty && _token.isNotEmpty) {
      await fetchUser(_userModel.userid);
      await loadWishes();
      await loadShoppingCart();
    }
  }

  Future<String?> fetchToken() async {
    return await _secureStorage.read(key: 'token');
  }

  Future<String?> fetchRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: 'token', value: accessToken);
    await _secureStorage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<UserModel?> fetchUserModel() async {
    String? userid = await _secureStorage.read(key: 'userid');
    if (userid != null) {
      return UserModel(userid: userid, userImage: '', userpoint: 0);
    }
    return null;
  }

  Future<void> fetchUser(String userid) async {
    _loading = true;
    notifyListeners();

    if (isTokenExpired(_token)) {
      await refreshToken();
    }

    try {
      final data = await _apiService.fetchUser(userid);
      _userModel = UserModel(
        userid: userid,
        userImage: data['retdata']['images'][0].toString(),
        userpoint: data['retdata']['userpoint'],
        email: data['retdata']['email'],
        username: data['retdata']['username'],
        gender: data['retdata']['gender'],
        birthday: data['retdata']['birthday'],
      );
      _loading = false;
    } catch (error) {
      if (error.toString().contains('401')) {
        await handle401Error(() => fetchUser(userid));
      } else {
        _error = error.toString();
        _loading = false;
      }
    }
    notifyListeners();
  }

  Future<void> loadWishes() async {
    if (_userModel.userid.isNotEmpty) {
      try {
        final res = await _apiService.getWishlists(_userModel.userid);
        if (res['retdata'] != null) {
          _favoriteItems = res['retdata'];
        } else {
          _favoriteItems = []; // Clear the list if the response is null
        }
        notifyListeners();
      } catch (error) {
        if (error.toString().contains('401')) {
          await handle401Error(loadWishes);
        } else {
          _error = error.toString();
          _favoriteItems = []; // Clear the list on error
          notifyListeners();
        }
      }
    }
  }

  Future<void> loadShoppingCart() async {
    if (_userModel.userid.isNotEmpty) {
      try {
        final res = await _apiService.getShoppingCart(_userModel.userid);
        if (res['retdata'] != null) {
          _shoppingCart = res['retdata'];
          notifyListeners();
        }
      } catch (error) {
        if (error.toString().contains('401')) {
          await handle401Error(loadShoppingCart);
        } else {
          _error = error.toString();
          notifyListeners();
        }
      }
    }
  }

  Future<void> fetchReviews(int itemId) async {
    _loading = true;
    notifyListeners();

    if (isTokenExpired(_token)) {
      await refreshToken();
    }

    try {
      final res = await _apiService.getReviews(itemId);
      if (res['retdata'] != null) {
        _reviews = res['retdata'];
      }
      _loading = false;
    } catch (error) {
      if (error.toString().contains('401')) {
        await handle401Error(() => fetchReviews(itemId));
      } else {
        _error = error.toString();
        _loading = false;
      }
    }
    notifyListeners();
  }

  Future<void> login(String token, String refreshToken) async {
    _token = token;
    decodeToken(token);

    // Store tokens securely
    await saveTokens(token, refreshToken);

    await fetchUser(_userModel.userid);
    await loadWishes();
    await loadShoppingCart();
    notifyListeners();
  }

  void decodeToken(String token) {
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    _userModel = UserModel(
      userid: decodedToken['userid'],
      userImage: '',
      userpoint: 0,
    );
    notifyListeners();
  }

  Future<void> storeUserModel(UserModel userModel) async {
    await _secureStorage.write(key: 'userid', value: userModel.userid);
  }

  bool get isLoggedIn => _token.isNotEmpty && _userModel.userid.isNotEmpty;

  Future<void> setFavorite(int itemid) async {
    if (!isLoggedIn) {
      _error = 'Та нэвтрэх хэрэгтэй';
      notifyListeners();
      return;
    }

    _saving = true;
    notifyListeners();

    if (isTokenExpired(_token)) {
      await refreshToken();
    }

    try {
      await _apiService.setFavorite(itemid, _userModel.userid, _token);
      await loadWishes();
    } catch (error) {
      if (error.toString().contains('401')) {
        await handle401Error(() => setFavorite(itemid));
      } else {
        _error = error.toString();
      }
    } finally {
      _saving = false;
      notifyListeners();
    }
  }

  Future<void> removeFavorite(int itemid) async {
    if (!isLoggedIn) {
      _error = 'Та нэвтрэх хэрэгтэй';
      notifyListeners();
      return;
    }

    _saving = true;
    notifyListeners();

    if (isTokenExpired(_token)) {
      await refreshToken();
    }

    try {
      await _apiService.removeFavorite(itemid, _token);
      await loadWishes();
    } catch (error) {
      if (error.toString().contains('401')) {
        await handle401Error(() => removeFavorite(itemid));
      } else {
        _error = error.toString();
      }
      _favoriteItems = _favoriteItems
          .where((item) => item['itemid'] != itemid)
          .toList(); // Remove the item from the list on error
    } finally {
      _saving = false;
      notifyListeners();
    }
  }

  Future<void> refreshToken() async {
    final refreshToken = await fetchRefreshToken();
    final accessToken = await fetchToken();

    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await http.post(
      Uri.parse('${getBaseURL()}/api/Systems/refresh-token'),
      body: jsonEncode({
        'access_token': accessToken,
        'expires_in': 0,
        'refresh_token': refreshToken,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response data: $data'); // Log the response data

      final newAccessToken = data['retdata']['access_token'] as String?;
      final newRefreshToken = data['retdata']['refresh_token'] as String?;

      if (newAccessToken != null && newRefreshToken != null) {
        await saveTokens(newAccessToken, newRefreshToken);
        _token = newAccessToken;
        decodeToken(newAccessToken);
        notifyListeners();
      } else {
        print('Failed to parse tokens. Response data: $data'); // Add this line
        throw Exception('Failed to parse new tokens');
      }
    } else {
      print(
          'Failed to refresh token. Status code: ${response.statusCode}'); // Add this line
      throw Exception('Failed to refresh token');
    }
  }

  bool isTokenExpired(String token) {
    try {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      int exp = decodedToken['exp'] * 1000; // Convert to milliseconds
      if (DateTime.now().millisecondsSinceEpoch > exp) {
        return true;
      }
    } catch (e) {
      print('Error decoding token: $e');
      return true; // If there is an error decoding the token, consider it expired.
    }
    return false;
  }

  Future<void> handle401Error(Function retryFunction) async {
    try {
      await refreshToken();
      await retryFunction();
    } catch (e) {
      _error = 'Failed to refresh token';
      _loading = false;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
    print('User is logged in: $isLoggedIn');
    print('Current user: ${_userModel}');
    print('token: ${token}');
  }
}
