import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_common_template/widgets/widgets.dart';
import 'package:flutter_common_template/services/services.dart';
import 'view_models/view_models.dart';

final pathIcon = SvgPicture.asset('assets/icons/path_icon.svg');
final taskIcon = SvgPicture.asset('assets/icons/task_icon.svg');
final menuIcon = SvgPicture.asset('assets/icons/menu_icon.svg');
final locationIcon = SvgPicture.asset('assets/icons/location_icon.svg');

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> showSelectEnvDialog(
      BuildContext context, HomeViewModel vm) async {
    var data = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => SelectEnvDialog(),
    );

    if (data != null) {
      AppEnvironment env = data['env'];

      if (vm.appEnv?.env != env.env) {
        /// 退出登录
        vm.logout();

        /// 切换环境
        vm.setAppEnv(env);
      }
    }
  }

  Widget _buildEnvView(HomeViewModel vm) {
    return Positioned(
      left: 16.0,
      right: 16.0,
      bottom: 32.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('当前环境'),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Text('${vm.appEnv?.name}'),
            onPressed: () => showSelectEnvDialog(context, vm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: TabNavigator());
  }
}
