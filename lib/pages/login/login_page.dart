import 'package:flutter/cupertino.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/utils/utils.dart';
import 'package:flutter_common_template/models/models.dart';
import 'actions/actions.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      model: _ViewModel(),
      builder: (context, vm) {
        return CupertinoPageScaffold(
          child: Container(
            // decoration: new BoxDecoration(
            // image: new DecorationImage(
            //   image: new AssetImage('assets/images/login/ic_login_bg.png'),
            //   fit: BoxFit.fill,
            // ),
            // ),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 112, left: 52),
                          child: Text(
                            '欢迎登录',
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 9, left: 52),
                          child: Text(
                            'Flutter开发通用模板',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 32, left: 52, right: 52),
                            height: 40,
                            child: CupertinoButton(
                              padding: EdgeInsets.all(0),
                              color: AppColors.darkBlueColor,
                              onPressed: vm.login,
                              disabledColor: AppColors.darkBlackColor,
                              borderRadius: BorderRadius.circular(2),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '登录',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel extends BaseModel<AppState> {
  _ViewModel();

  Function login;

  _ViewModel.build({
    @required this.login,
  }) : super(equals: []);

  @override
  _ViewModel fromStore() {
    return new _ViewModel.build(
      login: () => dispatch(LoginAction()),
    );
  }
}
