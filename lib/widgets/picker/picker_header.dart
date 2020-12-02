import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/utils/utils.dart';

class PickerHeader extends StatelessWidget {
  const PickerHeader({Key? key, this.onConfirm, this.onCancel, this.title})
      : super(key: key);

  final String? title;
  final Function? onCancel;
  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
            bottom:
                BorderSide(color: CupertinoColors.extraLightBackgroundGray)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15),
            child: CupertinoButton(
              minSize: 32.0,
              padding: EdgeInsets.all(0),
              child: Text(
                '取消',
                style: TextStyle(fontSize: 16, color: AppColors.textGreyColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title == null
              ? Container()
              : Container(
                  child: Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: AppColors.textColor),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: CupertinoButton(
              minSize: 32.0,
              padding: EdgeInsets.all(0),
              child: Text(
                '确定',
                style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
              ),
              onPressed: onConfirm,
            ),
          ),
        ],
      ),
    );
  }
}
