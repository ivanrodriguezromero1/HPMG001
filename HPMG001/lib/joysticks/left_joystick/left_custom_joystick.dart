import 'package:flutter/material.dart';
import 'package:hpmg001/joysticks/custom_joystick_impl.dart';

class LeftCustomJoystick extends CustomJoystickImpl {
  LeftCustomJoystick() {
    baseColor = const Color.fromRGBO(58, 42, 51, 0.35);
    thumbColor = const Color.fromRGBO(58, 42, 51, 0.60);
  }
  @override
  void defaultPosition() {
    baseCenter = Offset(baseCenterMinX*2, 3*height/4);
    thumbCenter = Offset(baseCenterMinX*2, 3*height/4);
  }
}