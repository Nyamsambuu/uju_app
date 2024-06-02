// lib/routes/auth_guard.dart
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/app_provider.dart';
import 'package:uju_app/routes/app_router.dart'; // Import the correct file

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final appProvider = router.navigatorKey.currentContext!.read<AppProvider>();

    // Wait until the provider is initialized
    await appProvider.initialize();

    if (appProvider.token.isNotEmpty &&
        appProvider.userModel.userid.isNotEmpty) {
      resolver.next(true);
    } else {
      router
          .replace(LoginRoute()); // Ensure LoginRoute is correct and generated
    }
  }
}
