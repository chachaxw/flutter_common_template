import 'package:dio/dio.dart';

class LoginInterceptor extends Interceptor {
  final Function()? handleUnAuth;

  LoginInterceptor({this.handleUnAuth});

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    var isLogin = response.data!["isLogin"];

    if (isLogin == "N") {
      handleUnAuth!();
    } else {
      handler.next(response);
    }
  }

  @override
  Future onError(DioError e, ErrorInterceptorHandler handler) async {
    // Do something with response error
    print("*** 错误信息 *** ${e.message}");
    return e;
  }
}
