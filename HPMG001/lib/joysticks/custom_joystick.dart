import 'package:flutter/material.dart';

abstract class CustomJoystick {
  late double top;
  late double left;
  late double width;
  late double height;
  late Color baseColor;
  late Color thumbColor;
  late double baseRadius;
  late double thumbRadius;
  late Offset basePosition;
  late Offset thumbPosition;
  late double baseMinX;
  late double baseMaxX;
  late double baseMinY;
  late double baseMaxY;
  void defaultPosition();
  Offset calculateBaseOffset();
  Offset calculateThumbOffset();
}