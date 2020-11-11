import 'package:flutter/cupertino.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/store.dart';
import 'package:flutter_common_template/app.dart';
import 'package:flutter_common_template/utils/utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = handleException;
  NavigateAction.setNavigatorKey(navigatorKey);

  await loadLocalData(store);
  runApp(App(store: store, navigatorKey: navigatorKey));
}
