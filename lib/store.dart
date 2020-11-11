import 'package:async_redux/async_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/services/services.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/utils/utils.dart';

final Store store = new Store<AppState>(
  initialState: AppState.initialState(),
  actionObservers: [Log.printer(formatter: Log.verySimpleFormatter)],
  modelObserver: DefaultModelObserver(),
);

Future<void> loadLocalData(Store store) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String appEnv = pref.getString(SharedKeys.appEnv);

  // 进入App前首先判断运行环境
  AppEnvironment currentEnv = getAppEnv(appEnv);

  print('当前运行环境 ${currentEnv?.name}');
  store.dispatch(SaveAppEnvAction(currentEnv));

  // 加载用户的令牌
  String token = pref.getString(SharedKeys.accessToken);

  if (token != null && token.length > 0) {
    RequestConfig.instance.userToken = token;
    RequestConfig.instance.env = currentEnv?.env;
  }
}
