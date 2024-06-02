import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:uju_app/models/user_model.dart';
import 'package:uju_app/api/api_service.dart';

class AppProvider with ChangeNotifier {
  UserModel _userModel = UserModel(userid: '', userImage: '', userpoint: 0);
  List<dynamic> _shoppingCart = [];
  List<dynamic> _favoriteItems = [];
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
    try {
      final data = await _apiService.fetchUser(userid);
      _userModel = UserModel(
        userid: userid,
        userImage: data['retdata']['images'][0],
        userpoint: data['retdata']['userpoint'],
      );
      _loading = false;
    } catch (error) {
      _error = error.toString();
      _loading = false;
    }
    notifyListeners();
  }

  Future<void> loadWishes() async {
    if (_userModel.userid.isNotEmpty) {
      try {
        final res = await _apiService.getWishlists(_userModel.userid);
        if (res['retdata'] != null) {
          _favoriteItems = res['retdata'];
          notifyListeners();
        }
      } catch (error) {
        _error = error.toString();
        notifyListeners();
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
        _error = error.toString();
        notifyListeners();
      }
    }
  }

  Future<void> login(String token) async {
    _token = token;
    decodeToken(token);

    // Store token securely
    await storeToken(token);

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

  Future<void> storeToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<void> storeUserModel(UserModel userModel) async {
    await _secureStorage.write(key: 'userid', value: userModel.userid);
  }
}
