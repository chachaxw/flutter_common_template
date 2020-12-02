import 'dart:core';
// ignore: import_of_legacy_library_into_null_safe
import 'package:jpush_flutter/jpush_flutter.dart';

class JPushManager {
  static var manager = JPushManager();
  late JPush jpush;

  JPushManager() {
    jpush = JPush();
  }

  void startPush() {
    jpush.setup(
      appKey: "xxx", // TODO: 添加JPush appKey
      production: false,
      channel: 'developer-default',
      debug: true,
    );

    clearBadge();
    print(getRegisId());

    jpush.applyPushAuthority(
      new NotificationSettingsIOS(sound: true, alert: true, badge: true),
    );

    try {
      ///暂无处理点击通知进app
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          clearBadge();
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          clearBadge();
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
        },
      );
    } on Exception {
      print('Failed to get platform version.');
    }
  }

  //清除app图标上通知红点
  void clearBadge() {
    jpush.setBadge(0);
  }

  //设置通知红点数量
  void setBadge(int badge) {
    jpush.setBadge(badge);
  }

  ///app端控制推送接收与关闭 登录后打开， 退出登录后关闭
  //开始接收推送
  void setPushAlias() {
    jpush.setAlias("device_manager");
  }

  //关闭推送
  void deleteAlisa() {
    jpush.deleteAlias();
  }

  Future<String> getRegisId() {
    return jpush.getRegistrationID();
  }
}
