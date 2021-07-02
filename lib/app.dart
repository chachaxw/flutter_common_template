import 'package:flutter/cupertino.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/pages/pages.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/utils/utils.dart';
import 'package:flutter_common_template/routes.dart';
import 'package:flutter_common_template/core/base/base.dart';

class App extends StatelessWidget {
  final Store<AppState> store;
  final GlobalKey<NavigatorState> navigatorKey;

  App({required this.store, required this.navigatorKey}) : super();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        model: _ViewModel(),
        builder: (context, vm) {
          return CupertinoApp(
            title: 'Flutter开发通用模板',
            color: AppColors.textColor,
            routes: routes,
            navigatorKey: navigatorKey,
            theme: CupertinoThemeData(
              primaryColor: AppColors.primaryColor,
              scaffoldBackgroundColor: AppColors.backgroundColor,
              barBackgroundColor: CupertinoColors.white,
            ),
            onGenerateRoute: _onGenerateRoute,
            home: UserExceptionDialog<AppState>(
              child: vm.isLogin ? HomePage().buildPage(context) : LoginPage(),
              onShowUserExceptionDialog:
                  (BuildContext context, UserException userException) {
                vm.showDialog(context, userException.msg);
              },
            ),
          );
        },
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    return _buildRoute(settings);
  }

  CupertinoPageRoute _buildRoute(RouteSettings settings) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (BuildContext context) =>
          pageRoute(context, routeSettings: settings),
    );
  }
}

class _ViewModel extends AppBaseModel<AppState> {
  _ViewModel();

  late bool isLogin;
  late Function showDialog;

  _ViewModel.build({
    required this.isLogin,
    required this.showDialog,
  }) : super(equals: [isLogin]);

  @override
  _ViewModel fromStore() {
    return new _ViewModel.build(
      isLogin: state.loginState.isLogin,
      showDialog: (BuildContext context, String msg) =>
          dispatch!(ShowDialogAction(context, msg)),
    );
  }
}
