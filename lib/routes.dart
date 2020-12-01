// Global app routes and app page keys
import 'package:flutter/widgets.dart';
import 'package:flutter_common_template/core/base/base.dart';
import 'package:flutter_common_template/pages/pages.dart';

class AppRoutes {
  static const String homePage = '/home';
  static const String loginPage = '/login';
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.loginPage: (BuildContext context) => LoginPage(),
};

Widget pageRoute(BuildContext context,
    {required RouteSettings routeSettings}) {
  return (_pageForRoute(routeSettings)..arguments = routeSettings.arguments)
      .buildPage(context);
}

BasePage _pageForRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AppRoutes.homePage:
      return HomePage();
    default:
      return HomePage();
  }
}