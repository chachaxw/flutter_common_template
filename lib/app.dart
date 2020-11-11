import 'package:flutter/cupertino.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/pages/pages.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/utils/utils.dart';
import 'package:flutter_common_template/routes.dart';

class App extends StatelessWidget {
  final Store<AppState> store;
  final GlobalKey navigatorKey;

  App({this.store, this.navigatorKey}) : super();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        model: _ViewModel(),
        builder: (context, vm) {
          return CupertinoApp(
            title: 'Flutter开发通用模板',
            routes: routes,
            navigatorKey: navigatorKey,
            theme: CupertinoThemeData(
              primaryColor: AppColors.primaryColor,
              scaffoldBackgroundColor: AppColors.backgroundColor,
            ),
            home: UserExceptionDialog<AppState>(
              child: vm.isLogin ? HomePage() : LoginPage(),
            ),
          );
        },
      ),
    );
  }
}

class _ViewModel extends BaseModel<AppState> {
  _ViewModel();

  bool isLogin;

  _ViewModel.build({
    @required this.isLogin,
  }) : super(equals: [isLogin]);

  @override
  _ViewModel fromStore() {
    return new _ViewModel.build(
      isLogin: state.loginState.isLogin,
    );
  }
}
