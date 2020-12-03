import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_common_template/widgets/widgets.dart';
import 'package:flutter_common_template/store.dart';
import 'package:flutter_common_template/utils/utils.dart';
import 'package:flutter_common_template/models/models.dart';
import 'page_status.dart';
import 'base_state.dart';
import 'base_model.dart';
import 'base_widget.dart';

abstract class _PageStateLifecycle<VM extends AppBaseModel,
    St extends BaseState> {
  void onInit(Store<St> store) {}

  void onInitialBuild(BuildContext context, VM vm) {}

  void onDispose(Store<St> store) {}

  void onDidChange(VM vm) {}

  Widget build(BuildContext context, VM vm);

  void onRefresh(
      BuildContext context, ValueNotifier<PageStatus> pageStatusNotifier) {}
}

mixin _PageStatusWidgetsMiXin<VM extends AppBaseModel, St extends BaseState>
    on _PageStateLifecycle<VM, St> {
  Widget loadingWidget(VM vm) {
    return LoadingWidget(vm);
  }

  Widget emptyWidget(VM vm, BasePage basePage) {
    return EmptyWidget(
      vm,
      basePage: basePage,
    );
  }
}

abstract class BasePage<VM extends AppBaseModel, St extends BaseState>
    extends _PageStateLifecycle<VM, St> with _PageStatusWidgetsMiXin<VM, St> {
  late BuildContext _context;
  BuildContext get context => _context;

  dynamic arguments;

  late St _state;
  St get state => _state;

  late Dispatch<St> _dispatch;
  Dispatch<St> get dispatch => _dispatch;

  BasePage({this.arguments});

  VM createViewModel(BuildContext context);

  // St createState(BuildContext context);

  AppState createState(BuildContext context) {
    return store.state;
  }

  Widget buildPage(BuildContext context) {
    return buildStoreConnector(context);
  }

  StoreConnector<St, VM> buildStoreConnector(BuildContext context) {
    return StoreConnector<St, VM>(
      onInit: onInit,
      onInitialBuild: (VM vm) {
        onInitialBuild(context, vm);
      },
      onDispose: onDispose,
      onDidChange: onDidChange,
      model: createViewModel(context),
      builder: (BuildContext context, VM vm) {
        Store<St> store = StoreProvider.of<St>(context, null);

        this._dispatch = store.dispatch;
        this._context = context;
        this._state = store.state;

        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
          navigationBar: buildHeader(context, vm),
          child: _buildContent(context, _state, vm),
        );
      },
    );
  }

  bool hideHeader() {
    return false;
  }

  bool resizeToAvoidBottomInset() {
    return false;
  }

  ObstructingPreferredSizeWidget? buildHeader(BuildContext context, VM vm) {
    if (hideHeader()) {
      return null;
    }

    return CupertinoNavigationBar(
      border: null,
      middle: _buildTitle(context, vm),
      leading: _buildBackWidget(context, vm),
      trailing: _rightTitleWidget(context, vm),
      backgroundColor: CupertinoColors.white,
    );
  }

  String title() {
    return '';
  }

  Widget centerTitleWidget(BuildContext context, VM vm) {
    return Text(
      title(),
      style: TextStyle(
        color: AppColors.textColor,
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget? rightTitleWidget(BuildContext context, VM vm) {
    return null;
  }

  Widget? _rightTitleWidget(BuildContext context, VM vm) {
    return rightTitleWidget(context, vm);
  }

  Widget _buildTitle(BuildContext context, VM vm) {
    return centerTitleWidget(context, vm);
  }

  Widget _buildBackWidget(BuildContext context, VM vm) {
    return CupertinoButton(
      minSize: 32.0,
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.back),
      onPressed: () {
        onPressBack(context, vm);
      },
    );
  }

  void onPressBack(BuildContext context, VM vm) {
    pop();
  }

  void pop() {
    StoreProvider.of<St>(context, null).dispatch(NavigateAction.pop());
  }

  Widget _buildContent(BuildContext context, St state, VM vm) {
    return _BasePageWidget(
      basePage: this,
      state: state,
      vm: vm,
    );
  }
}

class _BasePageWidget<VM extends AppBaseModel, St extends BaseState>
    extends BaseWidget<St, VM> {
  final BasePage basePage;

  _BasePageWidget({required this.basePage, required St state, required VM vm})
      : super(state: state, vm: vm);

  @override
  State<StatefulWidget> createState() {
    return BaseWidgetState();
  }

  Widget buildWidget(BuildContext context) {
    switch (state?.pageStatus) {
      case PageStatus.EMPTY:
      case PageStatus.ERROR:
        return basePage.emptyWidget(vm, basePage);
      case PageStatus.CONTENT:
        return Container(
          color: AppColors.lightGreyColor,
          child: basePage.build(context, vm),
        );
      default:
        return basePage.loadingWidget(vm);
    }
  }
}
