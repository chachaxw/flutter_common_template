import 'package:flutter_common_template/core/base/base.dart';
import 'package:flutter_common_template/pages/login/models/models.dart';
import 'package:flutter_common_template/pages/home/models/models.dart';
import 'main_state.dart';

class AppState extends BaseState {
  LoginState loginState;

  // 首页状态
  HomeState homeState;

  // 全局通用状态  【包括 loading、toast、环境、等信息】
  MainState mainState;

  AppState({
    required this.loginState,
    required this.homeState,
    required this.mainState,
  });

  static AppState initialState() => AppState(
        loginState: LoginState.initialState(),
        mainState: MainState.initialState(),
        homeState: HomeState.initialState(),
      );

  AppState copy({
    LoginState? loginState,
    HomeState? homeState,
    MainState? mainState,
  }) =>
      AppState(
        mainState: mainState ?? this.mainState,
        homeState: homeState ?? this.homeState,
        loginState: loginState ?? this.loginState,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          loginState == other.loginState &&
          mainState == other.mainState &&
          homeState == other.homeState;

  @override
  int get hashCode =>
      loginState.hashCode ^ mainState.hashCode ^ homeState.hashCode;
}
