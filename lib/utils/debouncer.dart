import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  final int milliseconds;
  final VoidCallback action;
  Timer? _timer;

  Debouncer({required this.action, this.milliseconds = 500});

  run(VoidCallback action) {
    if (_timer == null) {
      return 0;
    }

    _timer!.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
