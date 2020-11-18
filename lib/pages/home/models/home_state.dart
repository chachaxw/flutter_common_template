import 'package:flutter_svg/svg.dart';

class TabItem {
  final String title;
  final SvgPicture icon;
  final SvgPicture activeIcon;

  TabItem({this.title, this.icon, this.activeIcon});
}

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
