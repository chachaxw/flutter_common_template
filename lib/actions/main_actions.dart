import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/http/http.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ShowDialogAction extends BaseAction {
  String msg;
  BuildContext context;

  ShowDialogAction(this.context, this.msg);

  @override
  AppState? reduce() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('温馨提示'),
          content: Container(
            child: Text(
              msg,
              style: TextStyle(height: 1.2),
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return null;
  }
}

class ShowToastAction extends BaseAction {
  String msg;
  BuildContext context;

  ShowToastAction(this.msg, this.context);

  @override
  AppState? reduce() {
    Toast.show(msg, context, gravity: 1, duration: 2);
    return null;
  }
}

class SaveAppEnvAction extends BaseAction {
  final AppEnvironment appEnv;

  SaveAppEnvAction(this.appEnv);

  @override
  Future<AppState> reduce() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    HttpConfig.instance.env = appEnv.env;
    pref.setString(SharedKeys.appEnv, appEnv.env.toString());

    return state.copy(mainState: mainState.clone()..appEnv = appEnv);
  }
}

class LoadingAction extends BaseAction {
  final bool isLoading;

  LoadingAction(this.isLoading);

  @override
  AppState reduce() =>
      state.copy(mainState: mainState.clone()..isLoading = isLoading);
}

class LogoutAction extends BaseAction {
  LogoutAction();

  void before() => dispatch(LoadingAction(true));

  @override
  Future<AppState> reduce() async {
    return state.copy(loginState: loginState.copy(isLogin: false));
  }

  void after() => dispatch(LoadingAction(false));
}
