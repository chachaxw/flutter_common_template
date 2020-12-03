import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/core/base/base.dart';
import 'package:flutter_common_template/utils/utils.dart';

class EmptyWidget<St extends BaseState, VM extends AppBaseModel>
    extends BaseWidget<St, VM> {
  final BasePage? basePage;

  EmptyWidget(VM vm, {this.basePage}) : super(vm: vm);

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.lightGreyColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 11),
            child: Text(
              '暂无数据，请重新加载',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.darkGreyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 80,
            height: 28,
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              color: AppColors.primaryColor,
              child: Text(
                '重新加载',
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.white,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                basePage?.onRefresh(
                    context, basePage!.state.pageStatusNotifier);
              },
            ),
          ),
        ],
      ),
    );
  }
}
