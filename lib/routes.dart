// Global app routes and app page keys
import 'package:flutter/widgets.dart';
import 'package:flutter_common_template/pages/pages.dart';

class AppRoutes {
  static const String homePage = '/home';
  static const String loginPage = '/login';
}

class AppRouteKeys {
  static final Key homePage = const Key('__homePage__');
  static final Key packPage = const Key('__packPage__');
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.homePage: (BuildContext context) => HomePage(),
  AppRoutes.loginPage: (BuildContext context) => LoginPage(),
};
