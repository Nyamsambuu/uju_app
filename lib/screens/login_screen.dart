import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/app_provider.dart';
import 'package:uju_app/routes/app_router.dart';
import 'package:uju_app/theme/app_theme.dart'; // Import the theme file if it is separate
import 'package:uju_app/api/auth_api.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
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

      if (data != null) {
        // Assuming the data contains 'userid' and 'token'
        final token = data['retdata']['access_token'];

        // Get the AppProvider and login
        final appProvider = Provider.of<AppProvider>(context, listen: false);
        await appProvider.login(token);

        // Show success toast
        Fluttertoast.showToast(
          msg: data['retmsg'] ?? 'Амжилттай нэвтэрлээ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        context.router.replaceAll([HomeRoute()]);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.router.push(HomeRoute());
          },
        ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFA541B),
                    ),
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
                    style: TextStyle(color: AppTheme.primaryColor),
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
                  icon: Icon(Icons.facebook_outlined, color: Colors.white),
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
