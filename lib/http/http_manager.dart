import 'dart:core';

// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity/connectivity.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:flutter_common_template/utils/utils.dart';

import 'http_error.dart';

typedef HttpSuccessCallback<T> = void Function(dynamic data);

typedef HttpFailureCallback<T> = void Function(HttpError data);

typedef T JsonParse<T>(dynamic data);

/// Dio请求封装
/// 1>：首先从本地数据库的缓存中读取数据，如果缓存有数据，就直接显示列表数据，同时去请求服务器，如果服务器返回数据了，这个时候就去比对服务器返回的数据与缓存中的数据，看是否一样；
/// 2>：如果比对结果是一样，那么直接return返回，不做任何操作；
/// 3>：如果比对结果不一样，就去刷新列表数据，同时把之前数据库中的数据删除，然后存储新的数据；
///
class HttpManager {
  /// 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  /// HTTP请求方法
  static const GET = 'get';
  static const POST = 'POST';
  static const DELETE = 'delete';
  static const PUT = 'put';
  static const PATCH = 'patch';

  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager() => _instance;

  late Dio _client;

  Dio get client => _client;

  HttpManager._internal() {
    BaseOptions options = BaseOptions(
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
    );
    _client = Dio(options);
  }

  /// 初始化公共属性
  ///
  /// [baseUrl] API地址前缀
  /// [connectTimeout] 连接超时时间
  /// [receiveTimeout] 接收超时时间
  /// [interceptors] 基础拦截器
  void init({
    required String baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
  }) {
    _client.options = _client.options.merge(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );

    if (interceptors != null && interceptors.isNotEmpty) {
      _client.interceptors.addAll(interceptors);
    }
  }

  /// 取消网络请求
  void cancel(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag]!.isCancelled) {
        _cancelTokens[tag]!.cancel();
      }
      _cancelTokens.remove(tag);
    }
  }

  /// restful处理
  String _restfulUrl(String url, Map<String, dynamic> params) {
    // restful 请求处理
    // /api/user/:user_id        user_id = 0
    // 最终生成 url 为     /api/user/27
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }

  /// GET异步网络请求
  ///
  /// [url] 网络请求地址不包含域名
  /// [params] url请求参数支持restful
  /// [options] 请求配置
  /// [tag] 请求统一标识，用于取消网络请求
  Future<T> get<T>({
    required String url,
    required String tag,
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
  }) async {
    return _request(
      url: url,
      method: GET,
      params: params,
      options: options,
      jsonParse: jsonParse,
      tag: tag,
    );
  }

  /// POST异步网络请求
  ///
  /// [url] 网络请求地址不包含域名
  /// [data] post 请求参数
  /// [params] url 请求参数支持 restful
  /// [options] 请求配置
  /// [tag] 请求统一标识，用于取消网络请求
  Future<T> post<T>({
    required String url,
    required String tag,
    data,
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
  }) async {
    return _request(
      url: url,
      method: POST,
      data: data,
      params: params,
      options: options,
      jsonParse: jsonParse,
      tag: tag,
    );
  }

  /// patch异步网络请求
  ///
  /// [url] 网络请求地址不包含域名
  /// [data] patch 请求参数
  /// [params] url 请求参数支持 restful
  /// [options] 请求配置
  /// [tag] 请求统一标识，用于取消网络请求
  Future<T> patch<T>({
    required String url,
    required String tag,
    data,
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
  }) async {
    return _request(
      url: url,
      method: PATCH,
      data: data,
      params: params,
      options: options,
      jsonParse: jsonParse,
      tag: tag,
    );
  }

  /// delete异步网络请求
  ///
  /// [url] 网络请求地址不包含域名
  /// [data] patch 请求参数
  /// [params] url 请求参数支持 restful
  /// [options] 请求配置
  /// [tag] 请求统一标识，用于取消网络请求
  Future<T> delete<T>({
    required String url,
    required String tag,
    data,
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
  }) async {
    return _request(
      url: url,
      method: DELETE,
      data: data,
      params: params,
      options: options,
      jsonParse: jsonParse,
      tag: tag,
    );
  }

  /// 统一网络请求
  ///
  /// [url] 网络请求地址不包含域名
  /// [data] post 请求参数
  /// [params] url请求参数支持restful
  /// [options] 请求配置
  /// [tag] 请求统一标识，用于取消网络请求
  Future<T> _request<T>({
    required String url,
    required String tag,
    String? method,
    data,
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
  }) async {
    // 检查网络连接状态
    ConnectivityResult connectResult =
        await (Connectivity().checkConnectivity());

    if (connectResult == ConnectivityResult.none) {
      LogUtils.v("请求网络异常，请稍后重试！");
      throw HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！");
    }

    // 设置默认参数
    params = params ?? {};
    method = method ?? 'get';

    options?.method = method;
    options = options ?? Options(method: method);

    url = _restfulUrl(url, params);

    try {
      CancelToken? cancelToken;

      cancelToken =
          _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
      _cancelTokens[tag] = cancelToken!;

      Response<Map<String, dynamic>>? response = await _client.request(
        url,
        queryParameters: params,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );

      String statusCode = response.data["statusCode"];

      if (statusCode == "0") {
        if (jsonParse != null) {
          return jsonParse(response.data["data"]);
        } else {
          return response.data["data"];
        }
      } else {
        String message = response.data["statusDesc"];
        // 只能用 Future，外层有 try catch
        return Future.error(HttpError(statusCode, message));
      }
    } on DioError catch (e, s) {
      LogUtils.v("请求出错：$e\n$s");
      throw HttpError.dioError(e);
    } catch (e, s) {
      LogUtils.v("未知异常出错：$e\n$s");
      throw HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！");
    }
  }

  /// 文件上传
  ///
  /// [url] 网络请求地址不包含域名
  /// [data] post 请求参数
  /// [onSendProgress] 上传进度
  /// [params] url 请求参数支持 restful
  /// [options] 请求配置
  /// [tag] 请求统一标识，用于取消网络请求
  Future<T> upload<T>({
    required String url,
    required String tag,
    FormData? data,
    ProgressCallback? onSendProgress,
    Map<String, dynamic>? params,
    Options? options,
    JsonParse<T>? jsonParse,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      LogUtils.v("请求网络异常，请稍后重试！");
      throw (HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
    }

    //设置默认值
    params = params ?? {};

    //强制 POST 请求
    options?.method = POST;

    options = options ?? Options(method: POST);

    url = _restfulUrl(url, params);

    try {
      CancelToken? cancelToken;

      cancelToken =
          _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
      _cancelTokens[tag] = cancelToken!;

      Response<Map<String, dynamic>>? response = await _client.request(
        url,
        onSendProgress: onSendProgress,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );

      String statusCode = response.data["statusCode"];

      if (statusCode == "0") {
        // 成功
        if (jsonParse != null) {
          return jsonParse(response.data["data"]);
        } else {
          return response.data["data"];
        }
      } else {
        //失败
        String message = response.data["statusDesc"];
        LogUtils.v("请求服务器出错：$message");
        return Future.error((HttpError(statusCode, message)));
      }
    } on DioError catch (e, s) {
      LogUtils.v("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e, s) {
      LogUtils.v("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
    }
  }

  /// 下载文件
  ///
  /// [url] 下载地址
  /// [savePath] 文件保存路径
  /// [onReceiveProgress] 文件下载进度
  /// [data] post请求参数
  /// [params] url请求参数支持restful
  /// [options] 请求配置
  /// [tag] 请求统一标识，用于取消网络请求
  Future<Response> download({
    required String url,
    required savePath,
    required String tag,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? params,
    data,
    Options? options,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      LogUtils.v("请求网络异常，请稍后重试！");
      throw (HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
    }

    // 设置下载不超时
    int receiveTimeout = 0;
    options ??= options == null
        ? Options(receiveTimeout: receiveTimeout)
        : options.merge(receiveTimeout: receiveTimeout);

    //设置默认值
    params = params ?? {};

    url = _restfulUrl(url, params);

    try {
      CancelToken? cancelToken;

      cancelToken =
          _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
      _cancelTokens[tag] = cancelToken!;

      return _client.download(
        url,
        savePath,
        data: data,
        options: options,
        queryParameters: params,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e, s) {
      LogUtils.v("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e, s) {
      LogUtils.v("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
    }
  }
}
