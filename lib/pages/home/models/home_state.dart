class HomeState {
  final String title;

  HomeState({this.title});

  static HomeState initialState() => HomeState(title: 'Home');

  HomeState copy({String title}) => HomeState(title: title);

  @override
  String toString() {
    return 'HomeState{}';
  }
}
