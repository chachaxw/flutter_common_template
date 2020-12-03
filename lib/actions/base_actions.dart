import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/utils/utils.dart';
import 'package:flutter_common_template/pages/home/models/models.dart';
import 'package:flutter_common_template/pages/login/models/models.dart';

abstract class BaseAction extends ReduxAction<AppState> {
  LoginState get loginState => state.loginState;
  MainState get mainState => state.mainState;
  HomeState get homeState => state.homeState;

  showToast(
    BuildContext buildContext,
    String msg, {
    int duration = 2,
    int gravity = 1,
    Color backgroundColor = const Color(0xAA000000),
    Color textColor = AppColors.whiteColor,
    double backgroundRadius = 20,
  }) {
    Toast.show(
      msg,
      buildContext,
      gravity: gravity,
      duration: duration,
      textColor: textColor,
      backgroundColor: backgroundColor,
    );
  }

  showLoading({String? msg, Widget? indicator}) {
    EasyLoading.show(
      status: msg ?? '加载中…',
      indicator: indicator,
    );
  }

  showSuccess({String? msg, Duration? duration}) {
    EasyLoading.showSuccess(
      msg ?? '操作成功',
      duration: duration,
    );
  }

  showError({String? msg, Duration? duration}) {
    EasyLoading.showError(
      msg ?? '操作失败',
      duration: duration ?? Duration(seconds: 2),
    );
  }

  showWarn({String? msg, Duration? duration}) {
    EasyLoading.dismiss(animation: false);
    EasyLoading.showInfo(
      msg ?? '操作警告',
      duration: duration,
    );
  }

  dismiss() {
    EasyLoading.dismiss();
  }
}
