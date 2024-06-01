// lib/routes/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:uju_app/screens/home_screen.dart';
import 'package:uju_app/screens/orders_page.dart';
import 'package:uju_app/screens/profile_page.dart';
import 'package:uju_app/components/menu_categories.dart';
import 'package:uju_app/screens/search_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: OrdersRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: MenuCategoriesRoute.page),
      ];
}

class $AppRouter {}
