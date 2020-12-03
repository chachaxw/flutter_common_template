import 'package:flutter_common_template/http/env.dart';
import 'package:flutter_common_template/utils/utils.dart';

class MainState {
  bool isLoading;
  AppEnvironment appEnv;

  MainState({
    required this.isLoading,
    required this.appEnv,
  });

  static MainState initialState() => MainState(
        isLoading: false,
        appEnv: getAppEnv(NetworkEnvironment.PRODUCTION.toString()),
      );

  MainState clone({
    AppEnvironment? appEnv,
    bool? isLoading,
  }) =>
      MainState(
          isLoading: isLoading ?? this.isLoading,
          appEnv: appEnv ?? this.appEnv);
}
