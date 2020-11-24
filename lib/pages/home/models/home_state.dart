import 'package:flutter_svg/svg.dart';
import 'package:flutter_common_template/core/base/base.dart';
import 'package:flutter_common_template/utils/utils.dart';

class TabItem {
  final String label;
  final SvgPicture icon;
  final SvgPicture activeIcon;

  TabItem({this.label, this.icon, this.activeIcon});
}

List<TabItem> tabList = [
  TabItem(
    label: '首页',
    icon: AppIcons.homeIcon,
    activeIcon: AppIcons.homeActiveIcon,
  ),
  TabItem(
    label: '发现',
    icon: AppIcons.discoverIcon,
    activeIcon: AppIcons.discoverActiveIcon,
  ),
  TabItem(
    label: '我的',
    icon: AppIcons.userIcon,
    activeIcon: AppIcons.userActiveIcon,
  ),
];

class HomeState extends BaseState {
  final List<TabItem> tabs;

  HomeState({this.tabs});

  static HomeState initialState() => HomeState(tabs: tabList);

  HomeState copy({String title}) => HomeState();

  @override
  String toString() {
    return 'HomeState{}';
  }
}
