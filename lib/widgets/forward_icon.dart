import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/utils/utils.dart';

class ForwardIcon extends StatelessWidget {
  const ForwardIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(CupertinoIcons.forward, color: AppColors.textGreyColor);
  }
}
