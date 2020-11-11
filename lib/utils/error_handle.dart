import 'package:flutter/cupertino.dart';
import 'utils.dart';

Widget handleException(FlutterErrorDetails flutterErrorDetails) {
  print(flutterErrorDetails.toString());

  return Container(
    color: CupertinoColors.white,
    child: Center(
      child: Text(
        "Flutter 崩溃了",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
      ),
    ),
  );
}
