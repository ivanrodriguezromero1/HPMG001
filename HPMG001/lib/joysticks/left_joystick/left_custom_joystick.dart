import 'package:flutter/material.dart';
import '/models/scenery/screen.dart';
import '/joysticks/custom_joystick.dart';

class LeftCustomJoystick implements CustomJoystick {
  @override
  double top = 0;
  @override
  double left = 0;
  @override
  double width = Screen.screenSize.x/2;
  @override
  double height = Screen.screenSize.y;
  @override
  Color baseColor = const Color.fromRGBO(58, 42, 51, 0.35);
  @override
  Color thumbColor = const Color.fromRGBO(58, 42, 51, 0.60);
  @override
  double baseRadius = 45;
  @override
  double thumbRadius = 30;
  @override
  Offset basePosition = Offset.zero;
  @override
  Offset thumbPosition = Offset.zero;
  @override
  late double baseMinX;
  @override
  late double baseMaxX;
  @override
  late double baseMinY;
  @override
  late double baseMaxY;
  
  LeftCustomJoystick() {
    baseMinX = baseRadius + thumbRadius;
    baseMaxX = width - (baseRadius + thumbRadius);
    baseMinY = baseRadius + thumbRadius;
    baseMaxY = height - (baseRadius + thumbRadius);
  }

  @override
  void defaultPosition() {
    basePosition = Offset(baseRadius + thumbRadius, 3*height/4);
    thumbPosition = Offset(baseRadius + thumbRadius, 3*height/4);
  }
  @override
  Offset calculateBaseOffset() {
    return Offset(
      basePosition.dx - baseRadius,
      basePosition.dy - baseRadius
    );
  }
  @override
  Offset calculateThumbOffset() {
    return Offset(
      (thumbPosition.dx - thumbRadius).clamp(0, width - (2*thumbRadius)),
      (thumbPosition.dy - thumbRadius).clamp(0, height - (2*thumbRadius)),
    );
  }
}