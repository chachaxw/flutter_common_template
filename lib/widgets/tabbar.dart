import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({
    Key key,
    this.defaultColor,
    this.activeColor,
    this.textList,
    this.pageList,
  }) : super(key: key);

  final String defaultColor;
  final String activeColor;
  final List textList;
  final List pageList;

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int currentIndex = 0;

  final defaultColor = Colors.grey; //默认颜色
  final activeColor = Colors.blue; //选中颜色
  final List textList = ['首页', '搜索', '旅拍', '我的'];
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textList[currentIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          Center(child: Text('首页')),
          Center(child: Text('搜索')),
          Center(child: Text('旅拍')),
          Center(child: MaterialButton(onPressed: null, child: Text('退出登录'))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            //首页
            icon: Icon(Icons.home, color: defaultColor),
            activeIcon: Icon(Icons.home, color: activeColor),
            label: "首页",
          ),
          BottomNavigationBarItem(
            //搜索
            icon: Icon(Icons.search, color: defaultColor),
            activeIcon: Icon(Icons.search, color: activeColor),
            label: '搜索',
          ),
          BottomNavigationBarItem(
            //旅拍
            icon: Icon(Icons.camera_alt, color: defaultColor),
            activeIcon: Icon(Icons.camera_alt, color: activeColor),
            label: '旅拍',
          ),
          BottomNavigationBarItem(
            //我的
            icon: Icon(Icons.account_circle, color: defaultColor),
            activeIcon: Icon(Icons.account_circle, color: activeColor),
            label: '我的',
          ),
        ],
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
