import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_common_template/utils/utils.dart';

final checkedIcon = SvgPicture.asset('assets/icons/check_mark.svg');

class Radio extends StatelessWidget {
  final String label;
  final bool checked;
  final Function onChange;

  const Radio({
    Key key,
    this.label,
    this.onChange,
    this.checked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = checked ? AppColors.primaryColor : AppColors.borderGreyColor;

    return GestureDetector(
      onTap: onChange,
      child: Row(
        children: <Widget>[
          Text(label ?? ''),
          Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 1.5),
              color: checked ? AppColors.primaryColor : CupertinoColors.white,
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            child: checked
                ? SizedBox(child: checkedIcon, width: 16, height: 16)
                : null,
          ),
        ],
      ),
    );
  }
}
