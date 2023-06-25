import 'package:flutter/material.dart';
import 'package:hpmg001/joysticks/custom_joystick.dart';
import 'package:hpmg001/models/rosant/rosant.dart';

abstract class JoystickDetector {
  void onTapDown(TapDownDetails details, CustomJoystick customJoystick);
  void onPanStart(DragStartDetails details, CustomJoystick customJoystick);
  void onPanUpdate(DragUpdateDetails details, CustomJoystick customJoystick, Rosant rosant);
  void onPanEnd(DragEndDetails details, CustomJoystick customJoystick, Rosant rosant);
  void onTapUp(TapUpDetails details, CustomJoystick customJoystick, Rosant rosant);
}
