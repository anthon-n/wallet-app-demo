import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerProvider with ChangeNotifier {
  int secondsLeft = 300;
  Timer? _timer;
  void decrementSeconds() {
    _timer = Timer.periodic(
        const Duration(milliseconds: 1000), (_) {secondsLeft--; notifyListeners();});
  }

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    secondsLeft = 300;
    notifyListeners();
  }
}