import 'package:flutter/foundation.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/services/services.dart';
import 'package:flutter_common_template/core/base/base_model.dart';
import '../models/models.dart';

class HomeViewModel extends AppBaseModel<AppState> {
  HomeViewModel();

  Function logout;
  AppEnvironment appEnv;
  List<TabItem> tabs;
  Function(String) redirect;
  Function(AppEnvironment) setAppEnv;

  HomeViewModel.build({
    @required this.logout,
    @required this.appEnv,
    @required this.setAppEnv,
    @required this.redirect,
    @required this.tabs,
  }) : super(equals: [appEnv]);

  @override
  HomeViewModel fromStore() {
    MainState mainState = state.mainState;

    return new HomeViewModel.build(
      appEnv: mainState.appEnv,
      tabs: state.homeState.tabs,
      redirect: (String routeName) =>
          dispatch(NavigateAction.pushNamed(routeName)),
      logout: () => dispatch(LogoutAction()),
      setAppEnv: (AppEnvironment env) => dispatch(SaveAppEnvAction(env)),
    );
  }
}
