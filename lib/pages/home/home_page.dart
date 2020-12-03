import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/core/base/base.dart';
import 'package:flutter_common_template/models/models.dart';
import 'view_models/view_models.dart';
import 'widgets/home_container.dart';

class HomePage extends BasePage<HomeViewModel, AppState> {
  @override
  bool hideHeader() {
    return true;
  }

  @override
  ObstructingPreferredSizeWidget? buildHeader(
      BuildContext context, HomeViewModel vm) {
    return CupertinoNavigationBar(
      border: null,
      middle: Text("Flutter 开发模板"),
    );
  }

  @override
  Widget build(BuildContext context, HomeViewModel vm) {
    return HomeContainer(vm: vm);
  }

  @override
  HomeViewModel createViewModel(BuildContext context) {
    return HomeViewModel();
  }
}
