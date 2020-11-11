import 'dart:async';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/routes.dart';
import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/models/models.dart';

class LoginAction extends BaseAction {
  LoginAction();

  void before() => dispatch(LoadingAction(true));

  @override
  Future<AppState> reduce() async {
    dispatch(NavigateAction.pushNamed(AppRoutes.homePage));

    return state.copy(loginState: loginState.copy(isLogin: true));
  }

  void after() => dispatch(LoadingAction(false));
}
