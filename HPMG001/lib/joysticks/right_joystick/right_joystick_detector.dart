import 'package:flutter/material.dart';
import 'package:hpmg001/joysticks/custom_joystick.dart';
import 'package:hpmg001/joysticks/joystick_detector.dart';
import 'package:hpmg001/joysticks/joystick_detector_impl.dart';
import 'package:hpmg001/models/rosant/rosant.dart';

class RightJoystickDetector extends JoystickDetectorImpl {
  @override
  void onPanStart(DragStartDetails details, CustomJoystick customJoystick) {
    super.onPanStart(details, customJoystick);
  }
  @override
  void onPanUpdate(DragUpdateDetails details, CustomJoystick customJoystick, Rosant rosant) {
    super.onPanUpdate(details, customJoystick, rosant);

  }
  @override
  void onPanEnd(DragEndDetails details, CustomJoystick customJoystick, Rosant rosant) {
    super.onPanEnd(details, customJoystick, rosant);

  }
  @override
  void onTapUp(TapUpDetails details, CustomJoystick customJoystick, Rosant rosant) {
    super.onTapUp(details, customJoystick, rosant);

  }
}