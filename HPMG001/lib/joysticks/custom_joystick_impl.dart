import 'package:flutter/material.dart';
import '/models/scenery/screen.dart';
import '/joysticks/custom_joystick.dart';

class CustomJoystickImpl extends CustomJoystick {  
  CustomJoystickImpl() {
    top = 0;
    left = 0;
    width = Screen.screenSize.x/2;
    height = Screen.screenSize.y;
    baseColor = const Color.fromRGBO(255, 255, 255, 1);
    thumbColor = const Color.fromRGBO(255, 255, 255, 1);
    baseRadius = 45;
    thumbRadius = 30;
    baseCenter = Offset.zero;
    thumbCenter = Offset.zero;
    baseCenterMinX = baseRadius + thumbRadius;
    baseCenterMaxX = width - baseCenterMinX;
    baseCenterMinY = baseRadius + thumbRadius;
    baseCenterMaxY = height - baseCenterMinY;
  }
  @override
  void defaultPosition() {
  }
  @override
  Offset calculateBaseOffset() {
    return Offset(
      baseCenter.dx - baseRadius,
      baseCenter.dy - baseRadius
    );
  }
  @override
  Offset calculateThumbOffset() {
    return Offset(
      (thumbCenter.dx - thumbRadius).clamp(0, width - (2*thumbRadius)),
      (thumbCenter.dy - thumbRadius).clamp(0, height - (2*thumbRadius)),
    );
  }
}