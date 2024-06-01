import 'package:flutter/material.dart';
import 'package:uju_app/theme/app_theme.dart'; // Import the theme file if it is separate
import 'package:uju_app/api/auth_api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final AuthApi authApi = AuthApi();

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await authApi.login(
        _usernameController.text,
        _passwordController.text,
      );

      // ignore: unnecessary_null_comparison
      if (data != null) {
        // Show success toast
        Fluttertoast.showToast(
          msg: "Амжилттай",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // Handle successful login, e.g., navigate to another screen
        print('Login successful: $data');
        // Example: Navigate to another screen
        // Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Show error toast
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
      print('Error: $error');
      // Show error toast
      Fluttertoast.showToast(
        msg: "Хэрэглэгчийн нэр эсвэл нууц үг буруу байна.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Image.asset(
              'lib/assets/images/uju4.png',
              height: 100,
            ), // Replace with your logo asset
            SizedBox(height: 20),
            Text(
              'Нэвтрэх',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                hintText: 'Хэрэглэгчийн нэр эсвэл и-мэйл',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                hintText: 'Нууц үг',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      'Нэвтрэх',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Нууц үгээ мартсан уу?',
                    style: TextStyle(
                        color: AppTheme
                            .primaryColor), // Use the primary color from AppTheme
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Бүртгүүлэх',
                    style: TextStyle(color: AppTheme.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Өөрийн сошиал хаяг ашиглан нэвтрэх боломжтой.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.g_translate, color: Colors.white),
                  label: Text('Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.facebook, color: Colors.white),
                  label: Text('Facebook'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                'Бүртгүүлэх хуудас руу буцах',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
