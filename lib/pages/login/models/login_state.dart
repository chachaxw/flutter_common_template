class LoginState {
  final bool isLogin;

  LoginState({this.isLogin = false});

  static LoginState initialState() => LoginState(isLogin: false);

  LoginState copy({required bool isLogin}) => LoginState(isLogin: isLogin);

  @override
  String toString() {
    return 'LoginState{}';
  }
}
