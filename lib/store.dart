import 'package:async_redux/async_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/http/http.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/utils/utils.dart';

final Store<AppState> store = new Store<AppState>(
  initialState: AppState.initialState(),
  actionObservers: [Log.printer(formatter: Log.verySimpleFormatter)],
  modelObserver: DefaultModelObserver(),
);

Future<void> loadLocalData(Store store, String defaultEnv) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? appEnv = pref.getString(SharedKeys.appEnv);

  // 进入App前首先判断运行环境
  AppEnvironment currentEnv;

  /// 进入App前首先判断运行环境
  if (inProduction && defaultEnv == NetworkEnvironment.PRODUCTION.toString()) {
    /// main.dart 强制为生产环境
    currentEnv = getAppEnv(NetworkEnvironment.PRODUCTION.toString());
  } else {
    /// 默认运行环境为指定的环境
    currentEnv = getAppEnv(appEnv ?? defaultEnv);
  }

  print('当前运行环境 ${currentEnv.name}');
  store.dispatch(SaveAppEnvAction(currentEnv));

  // 加载用户的令牌
  String? token = pref.getString(SharedKeys.accessToken);

  // ignore: unnecessary_null_comparison
  if (token != null && token.length > 0) {
    HttpConfig.instance.userToken = token;
    HttpConfig.instance.env = currentEnv.env;
  }
}
