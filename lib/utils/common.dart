import 'package:flutter_common_template/http/env.dart';

AppEnvironment getAppEnv(String env) {
  AppEnvironment currentEnv = envList.firstWhere(
      (item) => item.env.toString() == env,
      orElse: () => envList[0]);

  return currentEnv;
}

String formatNumber(int num) {
  return num < 10 ? '0$num' : '$num';
}

/// 毫秒转换成 `x小时 y分 z秒`
/// @param {number} num 毫秒数
/// @return {string}
String formatMillSeconds(int? num) {
  if (num == null) {
    return '0分0秒';
  }

  num = (num ~/ 1000);

  int hours = ((num / 60 / 60) % 24).toInt();
  int minutes = ((num / 60) % 60).toInt();
  int seconds = num % 60;

  return '${hours > 0 ? formatNumber(hours) + "小时" : ""}${formatNumber(minutes)}分${formatNumber(seconds)}秒';
}
