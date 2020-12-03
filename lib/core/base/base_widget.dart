import 'package:flutter/cupertino.dart';
import 'base_state.dart';

abstract class BaseWidget<St extends BaseState, VM> extends StatefulWidget {
  final VM vm;
  final St? state;

  BaseWidget({this.state, required this.vm});

  @override
  State<StatefulWidget> createState() {
    return BaseWidgetState();
  }

  Widget buildWidget(BuildContext context);
}

class BaseWidgetState extends State<BaseWidget> {
  @override
  void initState() {
    super.initState();
    widget.state?.pageStatusNotifier.addListener(_onPageStatusChange);
  }

  @override
  void dispose() {
    widget.state?.pageStatusNotifier.removeListener(_onPageStatusChange);
    super.dispose();
  }

  void _onPageStatusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildWidget(context);
  }
}
