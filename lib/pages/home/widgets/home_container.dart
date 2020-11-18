import 'package:flutter/cupertino.dart';
import '../view_models/view_models.dart';

class HomeContainer extends StatefulWidget {
  final HomeViewModel vm;

  HomeContainer({@required this.vm});

  @override
  State<StatefulWidget> createState() {
    return HomeContainerState();
  }
}

class HomeContainerState extends State<HomeContainer> {
  Widget dispatchPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        dispatchPage = DispatchPage().buildPage(context);
      });
    });
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
            return dispatchPage ?? Container();
            break;
          case 1:
            return Center(child: Text('User Page'),);
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
            activeIcon: item.activeIcon,
            title: Text(item.title),
          ),
        )
        .toList();
  }
}
