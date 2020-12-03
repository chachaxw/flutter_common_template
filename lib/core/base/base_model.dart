import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';

abstract class AppBaseModel<St> extends BaseModel<St> {
  BuildContext? context;

  AppBaseModel({
    this.context,
    List? equals,
    Widget? widget,
  }) : super(
          equals: equals ?? [],
          widget: widget,
        );
}
