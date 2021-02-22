import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_template/app.dart';
import 'package:flutter_common_template/http/env.dart';
import 'package:flutter_common_template/store.dart';
import 'package:flutter_common_template/utils/utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = handleException;
  NavigateAction.setNavigatorKey(navigatorKey);

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //设置为透明
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  await loadLocalData(store, NetworkEnvironment.TEST.toString());
  runApp(App(store: store, navigatorKey: navigatorKey));
}
