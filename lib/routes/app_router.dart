// lib/routes/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:uju_app/screens/home_screen.dart';
import 'package:uju_app/screens/orders_page.dart';
import 'package:uju_app/screens/product_detail_screen.dart';
import 'package:uju_app/screens/profile_page.dart';
import 'package:uju_app/components/menu_categories.dart';
import 'package:uju_app/screens/search_page.dart';
import 'package:uju_app/screens/login_screen.dart';
import 'package:uju_app/routes/auth_guard.dart';
import 'package:uju_app/screens/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  final AuthGuard authGuard;

  AppRouter(this.authGuard);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(page: OrdersRoute.page, guards: [authGuard]),
        AutoRoute(page: ProfileRoute.page, guards: [authGuard]),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: MenuCategoriesRoute.page),
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: ProductDetailRoute.page),
      ];
}

class $AppRouter {}
