import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/models/models.dart';

class LoginAction extends BaseAction {
  LoginAction();

  void before() => dispatch(LoadingAction(true));

  @override
  AppState reduce() {
    return state.copy(loginState: loginState.copy(isLogin: true));
  }

  void after() => dispatch(LoadingAction(false));
}
