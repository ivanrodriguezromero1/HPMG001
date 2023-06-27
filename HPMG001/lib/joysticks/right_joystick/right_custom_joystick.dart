import 'package:flutter/material.dart';
import 'package:hpmg001/joysticks/custom_joystick_impl.dart';
import '/models/scenery/screen.dart';

class RightCustomJoystick extends CustomJoystickImpl {
  RightCustomJoystick() {
    left = Screen.screenSize.x/2;
    baseColor = const Color.fromRGBO(117, 4, 0, 0.35);
    thumbColor = const Color.fromRGBO(117, 4, 0, 0.60);
  }
  @override
  void defaultPosition() {
    baseCenter = Offset(width - (baseCenterMinX), 3*height/4);
    thumbCenter = Offset(width - (baseCenterMinX), 3*height/4);
  }
}