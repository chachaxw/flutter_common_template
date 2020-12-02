import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/utils/utils.dart';

const double _kPickerSheetHeight = 300.0;

class PickerDialog extends StatelessWidget {
  PickerDialog({Key? key, required this.picker}) : super(key: key);

  final Widget picker;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0), topRight: Radius.circular(0)),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: AppColors.darkGreyColor,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            bottom: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
