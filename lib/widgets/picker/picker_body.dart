import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/utils/utils.dart';

const double _kPickerItemHeight = 50.0;

class PickerBody extends StatefulWidget {
  final List list;
  final Function(int)? onChange;

  PickerBody({Key? key, this.list = const [], this.onChange}) : super(key: key);

  @override
  _PickerBodyState createState() => _PickerBodyState();
}

class _PickerBodyState extends State<PickerBody> {
  _PickerBodyState();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      itemExtent: _kPickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) {
        setState(() => selectedIndex = index);
        widget.onChange!(index);
      },
      children: List<Widget>.generate(
        widget.list.length,
        (int index) {
          return Center(
            child: Text(
              widget.list[index]?.name,
              style: TextStyle(
                fontSize: selectedIndex == index ? 16 : 13,
                fontWeight: selectedIndex == index
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: selectedIndex == index
                    ? AppColors.primaryColor
                    : AppColors.textColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
