import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/utils/utils.dart';
import 'base_model.dart';
import 'base_state.dart';
import 'base_widget.dart';
import 'page_status.dart';
import 'base_page.dart';

class BasePageWidget<St extends BaseState, VM extends AppBaseModel>
    extends BaseWidget<St, VM> {
  final BasePage basePage;

  BasePageWidget({this.basePage, St state, VM vm})
      : super(state: state, vm: vm);

  @override
  State<StatefulWidget> createState() {
    return BaseWidgetState();
  }

  Widget buildWidget(BuildContext context) {
    switch (state.pageStatus) {
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