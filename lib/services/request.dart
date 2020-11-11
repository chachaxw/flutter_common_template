import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';
import 'request_config.dart';
import 'env.dart';

// API返回数据
class ApiResponse {
  ApiResponse({
    @required this.success,
    @required this.statusCode,
    @required this.body,
    @required this.headers,
  });

  final bool success;
  final int statusCode;
  final dynamic body;
  final Map<String, String> headers;

  static ApiResponse from(http.Response response) {
    return ApiResponse(
      headers: response.headers,
      body: response.body.length > 0 ? json.decode(response.body) : '',
      statusCode: response.statusCode,
      success: (response.statusCode >= 200 && response.statusCode < 300),
    );
  }
}

class Request {
  Request();

  static Request _instance;
  static RequestConfig config = RequestConfig.instance;

  static Request get instance => _getInstance();

  static Request _getInstance() {
    if (_instance == null) {
      _instance = new Request._internal();
    }
    return _instance;
  }

  static String serializeQuery(Map<String, dynamic> params) {
    String paramStr = '';

    params?.forEach((String key, dynamic value) {
      if (value != null && key != null) {
        paramStr = paramStr + '$key=$value&';
      }
    });

    return paramStr;
  }

  static mergeHeaders(Map<String, String> headers) {
    Map<String, String> defaultHeaders = config.getHttpHeader();

    if (headers == null || headers.isEmpty) {
      return defaultHeaders;
    } else {
      return defaultHeaders.addAll(headers);
    }
  }

  Request._internal() {
    // 初始化
  }

  Future<bool> isNetworkAvailable() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (result == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else {
      return false;
    }
  }

  Future<ApiResponse> get(String uri,
      {Map<String, dynamic> params, Map<String, String> headers}) async {
    try {
      if (!await isNetworkAvailable()) {
        throw http.ClientException("网络未连接");
      }

      var paramStr = serializeQuery(params);
      var uriStr = config.getBaseUrl() + uri + '?' + paramStr;

      http.Response response = await http.get(Uri.encodeFull(uriStr),
          headers: mergeHeaders(headers));

      if (!inProduction) {
        print('请求链接$uriStr 返回数据${response.body}');
      }

      return ApiResponse.from(response);
    } on http.ClientException catch (e) {
      print('请求报错信息: e=${e.message}');
      return null;
    }
  }

  Future<ApiResponse> post(String uri,
      {Map<String, dynamic> body, Map<String, String> headers}) async {
    try {
      if (!await isNetworkAvailable()) {
        return throw http.ClientException("网络未连接");
      }

      uri = config.getBaseUrl() + uri;
      http.Response response = await http.post(uri,
          body: jsonEncode(body ?? ''), headers: mergeHeaders(headers));

      if (!inProduction) {
        print('请求链接$uri 返回数据${response.body}');
      }

      return ApiResponse.from(response);
    } on http.ClientException catch (e) {
      print('请求报错信息: e=${e.message}');
      return null;
    }
  }

  Future<ApiResponse> patch(String uri,
      {Map<String, dynamic> body, Map<String, String> headers}) async {
    try {
      if (!await isNetworkAvailable()) {
        return throw http.ClientException("网络未连接");
      }

      uri = config.getBaseUrl() + uri;
      http.Response response = await http.patch(uri,
          body: jsonEncode(body ?? ''), headers: mergeHeaders(headers));

      if (!inProduction) {
        print('请求链接$uri 返回数据${response.body}');
      }

      return ApiResponse.from(response);
    } on http.ClientException catch (e) {
      print('请求报错信息: e=${e.message}');
      return null;
    }
  }

  Future<ApiResponse> delete(String uri, {Map<String, String> headers}) async {
    try {
      if (!await isNetworkAvailable()) {
        return throw http.ClientException("网络未连接");
      }

      uri = config.getBaseUrl() + uri;
      http.Response response =
          await http.delete(uri, headers: mergeHeaders(headers));

      if (!inProduction) {
        print('请求链接$uri 返回数据${response.body}');
      }

      return ApiResponse.from(response);
    } on http.ClientException catch (e) {
      print('请求报错信息: e=${e.message}');
      return null;
    }
  }

  Future<http.StreamedResponse> multiPartPost(String uri, dynamic body,
      {Map<String, String> headers}) async {
    try {
      if (!await isNetworkAvailable()) {
        return throw http.ClientException("网络未连接");
      }

      var client = new http.MultipartRequest(
          "post", Uri.parse('${config.getBaseUrl()}$uri'));
      Map<String, String> defaultHeader = config.getHttpHeader();

      if (!inProduction) {
        print('请求链接$uri');
      }

      client.headers["Authorization"] = defaultHeader["Authorization"];
      client.fields["username"] = body["username"];
      client.fields["password"] = body["password"];

      return await client.send();
    } on http.ClientException catch (e) {
      print('请求报错信息: e=${e.message}');
      return null;
    }
  }

  bool isDev(NetworkEnvironment env) {
    return env == NetworkEnvironment.DEVELOPMENT;
  }

  bool isTest(NetworkEnvironment env) {
    return env == NetworkEnvironment.TEST;
  }

  bool isProd(NetworkEnvironment env) {
    return env == NetworkEnvironment.PRODUCTION;
  }
}
