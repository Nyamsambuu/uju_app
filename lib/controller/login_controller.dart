import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uju_app/api/auth_api.dart';
import 'package:uju_app/routes/app_router.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final AuthApi authApi = AuthApi();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    isLoading.value = true;
    try {
      final data = await authApi.login(
        usernameController.text,
        passwordController.text,
      );

      if (data != null) {
        Fluttertoast.showToast(
          msg: data['retmsg'] ?? "Амжилттай нэвтэрлээ.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Get.toNamed(HomeRoute.name); // Navigate to home
      } else {
        Fluttertoast.showToast(
          msg: "Invalid response from server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Хэрэглэгчийн нэр эсвэл нууц үг буруу байна.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
