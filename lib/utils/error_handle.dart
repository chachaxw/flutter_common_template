import 'package:flutter/cupertino.dart';
import 'color_utils.dart';

Widget handleException(FlutterErrorDetails flutterErrorDetails) {
  print('Flutter崩溃了: ${flutterErrorDetails.toString()}');

  return Container(
    color: AppColors.whiteColor,
    child: Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Text(
          "Flutter 崩溃了",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.errorColor,
          ),
        ),
      )
    ),
  );
}
