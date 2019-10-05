import 'package:flutter/cupertino.dart';
import 'package:vibrate/vibrate.dart';

mixin VibrationMixin<T extends StatefulWidget> on State<T> {
  bool _canVibrate = true;
  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];

  @override
  initState() {
    super.initState();
    initializeVibrationMixin();
  }

  initializeVibrationMixin() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? print("This device can vibrate")
          : print("This device cannot vibrate");
    });
  }

  vibrateSuccess() {
    try {
      if (_canVibrate) {
        Vibrate.feedback(FeedbackType.success);
      }
    } catch (e) {}
  }

  vibrateError() {
    try {
      if (_canVibrate) {
        Vibrate.feedback(FeedbackType.error);
      }
    } catch (e) {}
  }

  vibrate() {
    try {
      if (_canVibrate) {
        Vibrate.feedback(FeedbackType.selection);
      }
    } catch (e) {}
  }
}
