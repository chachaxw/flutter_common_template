import 'dart:core';
import 'env.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:package_info/package_info.dart';

class HttpConfig {
  String? userToken;
  late String appName;
  late String version;
  late String packageName;
  late String buildNumber;
  late NetworkEnvironment env;

  static final HttpConfig _instance = HttpConfig._internal();

  static HttpConfig get instance => _instance;

  // 默认生产环境 需要设置环境调 setAppEnv 方法
  HttpConfig._internal() {
    getAppInfo();
  }

  /// 设置App开发环境
  void setAppEnv(AppEnvironment? appEnv) {
    env = appEnv?.env ?? NetworkEnvironment.PRODUCTION;
  }

  /// 获取App基本信息
  Future<void> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    version = packageInfo.version;
    packageName = packageInfo.packageName;
    buildNumber = packageInfo.buildNumber;
  }

  /// 获取API Host基本配置
  String getBaseUrl() {
    switch (env) {
      case NetworkEnvironment.DEVELOPMENT:
        return "https://development.api.github.com";

      case NetworkEnvironment.PRODUCTION:
        return "https://api.github.com";

      case NetworkEnvironment.TEST:
        return "https://test.api.github.com";

      default:
        return "https://api.github.com";
    }
  }

  /// 获取HTTP请求头基本配置
  Map<String, String> getHttpHeader() {
    switch (env) {
      case NetworkEnvironment.DEVELOPMENT:
        return {
          "Authorization": userToken ?? "Basic xxxxx",
          "Content-Type": "application/json"
        };

      case NetworkEnvironment.PRODUCTION:
        return {
          "Authorization": userToken ?? "Basic xxxxx",
          "Content-Type": "application/json"
        };

      case NetworkEnvironment.TEST:
        return {
          "Authorization": userToken ?? "Basic xxxxx",
          "Content-Type": "application/json"
        };

      default:
        return {
          "Authorization": userToken ?? "Basic xxxxx",
          "Content-Type": "application/json"
        };
    }
  }
}
