class LoginState {
  final bool isLogin;

  LoginState({this.isLogin});

  static LoginState initialState() => LoginState(isLogin: false);

  LoginState copy({bool isLogin}) =>
      LoginState(isLogin: this.isLogin ?? isLogin);
}
