library pin_input_widget;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pin_input_widget/mixin/vibration_mixin.dart';

typedef OnPinCompleteCallback = Future<PinValidationResult> Function(
    String pin);

class PinValidationResult {
  bool isSuccessful = false;
  String errorMessage = "";
  PinValidationResult({
    this.isSuccessful,
    this.errorMessage,
  });
}

class EnterPinScreen extends StatefulWidget {
  final int pinLength;
  final String title;
  final OnPinCompleteCallback onPinCompleteCallback;
  final VoidCallback onSuccessful;
  final VoidCallback onFailure;
  final VoidCallback onLogout;
  final VoidCallback onClose;
  final Widget brandLogo;

  const EnterPinScreen({
    Key key,
    this.brandLogo,
    this.pinLength = 4,
    this.title = "Enter Your PIN",
    @required this.onPinCompleteCallback,
    this.onFailure,
    this.onSuccessful,
    this.onClose,
    this.onLogout,
  }) : super(key: key);
  @override
  _EnterPinScreenState createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> with VibrationMixin {
  bool isWorking = false;
  List<String> pin = List<String>(4);
  int activeIndex = 0;
  String errorMsg = "";

  Widget brandLogo;

  @override
  void initState() {
    super.initState();

    brandLogo = Icon(
      Icons.lock,
      color: Colors.white,
      size: 40,
    );

    if (widget.brandLogo != null) {
      brandLogo = widget.brandLogo;
    }

    pin = List<String>(widget.pinLength);
    activeIndex = 0;
    isWorking = false;
    errorMsg = "";
  }

  @override
  Widget build(BuildContext context) {
    double _width = (MediaQuery.of(context).size.width / 3) - 20;
    double _iconSize = 45;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Theme(
        data: ThemeData.dark(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      if (widget.onClose != null) {
                        widget.onClose();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    fit: StackFit.loose,
                    children: <Widget>[
                      brandLogo,
                      AnimatedOpacity(
                        opacity: isWorking ? 1.0 : 0.0,
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              constraints: BoxConstraints.tight(Size(30, 30)),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                    onPressed: () {
                      if (widget.onLogout != null) {
                        widget.onLogout();
                      }
                    },
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${widget.title == null || widget.title == "" ? 'Enter Your PIN' : widget.title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _makePinDots(
                      widget.pinLength,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "${errorMsg != null && errorMsg.isNotEmpty ? errorMsg : ''}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Table(
                    columnWidths: {
                      0: FixedColumnWidth(_width),
                      1: FixedColumnWidth(_width),
                      2: FixedColumnWidth(_width),
                    },
                    children: [
                      TableRow(children: [
                        IconButton(
                          iconSize: _iconSize,
                          icon: Icon(
                            MaterialCommunityIcons.numeric_1,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _addPin("1");
                          },
                        ),
                        IconButton(
                          iconSize: _iconSize,
                          icon: Icon(
                            MaterialCommunityIcons.numeric_2,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _addPin("2");
                          },
                        ),
                        IconButton(
                          iconSize: _iconSize,
                          icon: Icon(
                            MaterialCommunityIcons.numeric_3,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _addPin("3");
                          },
                        ),
                      ]),
                      TableRow(children: [
                        IconButton(
                          iconSize: _iconSize,
                          icon: Icon(
                            MaterialCommunityIcons.numeric_4,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _addPin("4");
                          },
                        ),
                        IconButton(
                          iconSize: _iconSize,
                          icon: Icon(
                            MaterialCommunityIcons.numeric_5,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _addPin("5");
                          },
                        ),
                        IconButton(
                          iconSize: _iconSize,
                          icon: Icon(
                            MaterialCommunityIcons.numeric_6,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _addPin("6");
                          },
                        ),
                      ]),
                      TableRow(
                        children: [
                          IconButton(
                            iconSize: _iconSize,
                            icon: Icon(
                              MaterialCommunityIcons.numeric_7,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _addPin("7");
                            },
                          ),
                          IconButton(
                            iconSize: _iconSize,
                            icon: Icon(
                              MaterialCommunityIcons.numeric_8,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _addPin("8");
                            },
                          ),
                          IconButton(
                            iconSize: _iconSize,
                            icon: Icon(
                              MaterialCommunityIcons.numeric_9,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _addPin("9");
                            },
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            height: 45.0,
                          ),
                          IconButton(
                            iconSize: _iconSize,
                            icon: Icon(
                              MaterialCommunityIcons.numeric_0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _addPin("0");
                            },
                          ),
                          IconButton(
                            iconSize: _iconSize,
                            icon: Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                              ),
                              child: Icon(
                                MaterialCommunityIcons.backspace,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            onPressed: () {
                              _removeLastPinEntry();
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _makePinDots(int length) {
    final pinDots = <Widget>[];

    for (var i = 0; i < length; i++) {
      pinDots.add(
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: pin[i] == null ? Colors.white30 : Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      );

      if (i != length - 1) {
        pinDots.add(
          SizedBox(
            width: 50,
          ),
        );
      }
    }

    return pinDots;
  }

  bool get isPinValid => pin.map((i) => i != null).reduce((i, j) => i && j);

  void _addPin(String num) {
    if (activeIndex >= pin.length) {
      vibrateError();
      return;
    }

    vibrate();

    setState(() {
      isWorking = false;
    });

    errorMsg = "";

    pin[activeIndex] = num;
    activeIndex += 1;
    print(pin);
    setState(() {});

    if (isPinValid) {
      _submitPin();
    }
  }

  void _removeLastPinEntry() {
    if (activeIndex <= 0) {
      activeIndex = 0;
    } else {
      activeIndex -= 1;
    }
    pin[activeIndex] = null;
    print(pin);
    setState(() {});
  }

  void _resetPin() {
    for (var i = 0; i < pin.length; i++) {
      pin[i] = null;
    }
    activeIndex = 0;
    setState(() {});
  }

  void _submitPin() async {
    if (!isPinValid) {
      vibrateError();
      return;
    }
    setState(() {
      isWorking = true;
    });

    if (widget.onPinCompleteCallback != null) {
      final result = await widget.onPinCompleteCallback(pin.join("").trim());
      if (result.isSuccessful) {
        if (widget.onSuccessful != null) {
          vibrateSuccess();
          widget.onSuccessful();
        }
      } else {
        errorMsg = result.errorMessage;
        if (widget.onFailure != null) {
          vibrateError();
          widget.onFailure();
        }
        _resetPin();
      }
    }

    setState(() {
      isWorking = false;
    });
    _resetPin();
  }
}
