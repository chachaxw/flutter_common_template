import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_template/core/base/base.dart';
import 'package:flutter_common_template/utils/utils.dart';

import 'shimmer.dart';

class LoadingWidget<St extends BaseState, VM extends AppBaseModel>
    extends BaseWidget<St, VM> {
  LoadingWidget(VM vm) : super(vm: vm);

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.lightGreyColor,
      child: Shimmer.fromColors(
        period: Duration(milliseconds: 2000),
        direction: ShimmerDirection.ltr,
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Text(
          'Flutter开发模板',
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
