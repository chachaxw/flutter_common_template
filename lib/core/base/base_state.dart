import 'package:flutter/widgets.dart';
import 'page_status.dart';

class BaseState {
  late ValueNotifier<PageStatus> _pageStatusNotifier;

  ValueNotifier<PageStatus> get pageStatusNotifier => _pageStatusNotifier;

  PageStatus get pageStatus => _pageStatusNotifier.value;

  set pageStatus(PageStatus pageStatus) {
    _pageStatusNotifier.value = pageStatus;
  }

  BaseState({ValueNotifier<PageStatus>? pageStatusNotifier}) {
    _pageStatusNotifier =
        pageStatusNotifier ?? ValueNotifier(PageStatus.CONTENT);
  }
}
