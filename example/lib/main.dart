import 'package:flutter/material.dart';
import 'package:pin_input_widget/pin_input_screen.dart';

void main() async {
  runApp(MaterialApp(
    home: EnterPinScreen(
      onPinCompleteCallback: (v) async {
        return PinValidationResult(isSuccessful: true, errorMessage: null);
      },
    ),
  ));
}
