import 'package:flutter/cupertino.dart';

const int _defaultColor = 0xFFF5F7FA;

class LabelView extends StatelessWidget {
  final int color;
  final String label;

  LabelView(this.label, {this.color = _defaultColor})
      : assert(
          label != "",
          'A non-null String must be provided to a Text widget.',
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 21),
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
