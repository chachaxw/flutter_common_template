import 'dart:core';
import 'env.dart';
import 'package:package_info/package_info.dart';

class RequestConfig {
  String appName;
  String version;
  String userToken;
  String packageName;
  String buildNumber;
  NetworkEnvironment env;

  static RequestConfig get instance => _getInstance();
  static RequestConfig _instance;
  static RequestConfig _getInstance() {
    if (_instance == null) {
      _instance = new RequestConfig._internal();
    }
    return _instance;
  }

  // 默认生产环境 需要设置环境调 setAppEnv 方法
  RequestConfig._internal() {
    getAppInfo();
  }

  void setAppEnv(AppEnvironment appEnv) {
    env = appEnv?.env ?? NetworkEnvironment.PRODUCTION;
  }

  Future<void> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    version = packageInfo.version;
    packageName = packageInfo.packageName;
    buildNumber = packageInfo.buildNumber;
  }

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
