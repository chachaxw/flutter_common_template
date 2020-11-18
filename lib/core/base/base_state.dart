import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_common_template/models/models.dart';
import 'package:flutter_common_template/store.dart';
import 'page_status.dart';

class BaseState {
  ValueNotifier<PageStatus> _pageStatusNotifier;

  ValueNotifier<PageStatus> get pageStatusNotifier => _pageStatusNotifier;

  PageStatus get pageStatus => _pageStatusNotifier.value;

  set pageStatus(PageStatus pageStatus) {
    _pageStatusNotifier.value = pageStatus;
  }

  BaseState({ValueNotifier<PageStatus> pageStatusNotifier}) {
    _pageStatusNotifier =
        pageStatusNotifier ?? ValueNotifier(PageStatus.CONTENT);
  }

  static Store<St> of<St extends BaseState>(BuildContext buildContext) {
    return StoreProvider.of<St>(buildContext, null);
  }

  /// 该方法支持child page 直接访问appState,  store 是全局的Store,
  AppState get appState => store.state;
}
