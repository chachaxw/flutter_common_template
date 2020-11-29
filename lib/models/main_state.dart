import 'package:flutter_common_template/http/env.dart';

class MainState {
  bool isLoading;
  AppEnvironment appEnv;

  MainState({
    this.isLoading,
    this.appEnv,
  });

  static MainState initialState() => MainState(
        isLoading: false,
        appEnv: null,
      );

  MainState clone() => MainState()
    ..appEnv = appEnv
    ..isLoading = isLoading;
}
