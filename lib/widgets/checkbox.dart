import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_common_template/utils/utils.dart';

final checkIcon = SvgPicture.asset('assets/icons/check_mark.svg');

class Checkbox extends StatefulWidget {
  final String? label;
  final bool checked;
  final Function(bool)? onChange;

  Checkbox({Key? key, this.label, this.checked = false, this.onChange})
      : super(key: key);

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  _CheckboxState();

  late bool checked;

  @override
  void initState() {
    super.initState();
  }

  void handleChange() {
    setState(() {
      checked = !widget.checked;
    });
    widget.onChange!(checked);
  }

  @override
  Widget build(BuildContext context) {
    Color color = checked ? AppColors.primaryColor : AppColors.borderGreyColor;

    return GestureDetector(
        onTap: handleChange,
        child: Row(children: <Widget>[
          Text(widget.label ?? ''),
          Container(
              width: 16,
              height: 16,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 1.5),
                color: checked ? AppColors.primaryColor : CupertinoColors.white,
              ),
              child: checked
                  ? SizedBox(child: checkIcon, width: 12, height: 12)
                  : null),
        ]));
  }
}
