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
  late Offset baseCenter;
  late Offset thumbCenter;
  late double baseCenterMinX;
  late double baseCenterMaxX;
  late double baseCenterMinY;
  late double baseCenterMaxY;
  void defaultPosition();
  Offset calculateBaseOffset();
  Offset calculateThumbOffset();
}