import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uju_app/providers/app_provider.dart';
import 'package:uju_app/providers/product_provider.dart';
import 'package:uju_app/routes/app_router.dart';
import 'package:uju_app/theme/app_theme.dart';
import 'package:uju_app/routes/auth_guard.dart';

void main() {
  final authGuard = AuthGuard();
  final appRouter = AppRouter(authGuard);

  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  MyApp({required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return MaterialApp.router(
            theme: AppTheme.lightTheme,
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
