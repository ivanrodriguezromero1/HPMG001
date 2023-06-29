import 'package:flutter/material.dart';
import 'package:hpmg001/controllers/rosant_controller.dart';
import 'package:hpmg001/joysticks/custom_joystick.dart';
import 'package:hpmg001/joysticks/joystick_detector_impl.dart';
import 'package:hpmg001/models/rosant/rosant.dart';

class LeftJoystickDetector extends JoystickDetectorImpl {
  @override
  void onPanUpdate(DragUpdateDetails details, CustomJoystick customJoystick, Rosant rosant) {
    super.onPanUpdate(details, customJoystick, rosant);
    RosantController.performMovement(rosant, unitVector: unitVector);
    RosantController.setMovingState(rosant, unitVector);
  }
  @override
  void onPanEnd(DragEndDetails details, CustomJoystick customJoystick, Rosant rosant) {
    super.onPanEnd(details, customJoystick, rosant);
    RosantController.performMovement(rosant);
    RosantController.setIdleState(rosant);
  }
  @override
  void onTapUp(TapUpDetails details, CustomJoystick customJoystick, Rosant rosant) {
    super.onTapUp(details, customJoystick, rosant);
    RosantController.performMovement(rosant);
    RosantController.setIdleState(rosant);
  }
}