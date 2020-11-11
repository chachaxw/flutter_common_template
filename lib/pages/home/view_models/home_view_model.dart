import 'package:flutter/foundation.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/services/services.dart';

import '../../../actions/main_actions.dart';

class HomeViewModel extends BaseModel<AppState> {
  HomeViewModel();

  Function logout;
  AppEnvironment appEnv;
  Function(String) redirect;
  Function(AppEnvironment) setAppEnv;

  HomeViewModel.build({
    @required this.logout,
    @required this.appEnv,
    @required this.setAppEnv,
    @required this.redirect,
  }) : super(equals: [appEnv]);

  @override
  HomeViewModel fromStore() {
    MainState mainState = state.mainState;

    return new HomeViewModel.build(
      appEnv: mainState.appEnv,
      redirect: (String routeName) =>
          dispatch(NavigateAction.pushNamed(routeName)),
      logout: () => dispatch(LogoutAction()),
      setAppEnv: (AppEnvironment env) => dispatch(SaveAppEnvAction(env)),
    );
  }
}
