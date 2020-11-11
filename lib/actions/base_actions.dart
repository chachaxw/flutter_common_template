import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/pages/home/models/models.dart';
import 'package:flutter_common_template/pages/login/models/models.dart';

abstract class BaseAction extends ReduxAction<AppState> {
  LoginState get loginState => state.loginState;
  MainState get mainState => state.mainState;
  HomeState get homeState => state.homeState;
}
