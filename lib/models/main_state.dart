import 'package:flutter_common_template/services/services.dart';

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
