import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_template/utils/color_utils.dart';
import '../view_models/view_models.dart';
import '../models/models.dart';

class HomeContainer extends StatefulWidget {
  final HomeViewModel vm;

  HomeContainer({@required this.vm});

  @override
  State<StatefulWidget> createState() {
    return HomeContainerState();
  }
}

class HomeContainerState extends State<HomeContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: buildBottomTabList(widget.vm),
        backgroundColor: CupertinoColors.white,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return Center(child: Text('首页'));
          case 1:
            return Center(child: Text('发现'));
          case 2:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("我的"),
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  CupertinoButton(
                    child: Text("退出登录"),
                    color: AppColors.primaryColor,
                    onPressed: () {
                      widget.vm.logout();
                    },
                  ),
                ],
              ),
            );
          default:
            return Container();
        }
      },
    );
  }

  List<BottomNavigationBarItem> buildBottomTabList(HomeViewModel vm) {
    return vm.tabs
        .map(
          (TabItem item) => BottomNavigationBarItem(
            icon: item.icon,
            label: item.label,
            activeIcon: item.activeIcon,
          ),
        )
        .toList();
  }
}
