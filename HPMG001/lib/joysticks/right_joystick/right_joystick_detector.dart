import 'package:flutter/material.dart';
import 'package:hpmg001/controllers/rosant_controller.dart';
import 'package:hpmg001/joysticks/custom_joystick.dart';
import 'package:hpmg001/joysticks/joystick_detector_impl.dart';
import 'package:hpmg001/models/rosant/rosant.dart';

class RightJoystickDetector extends JoystickDetectorImpl {
  @override
  void onPanUpdate(DragUpdateDetails details, CustomJoystick customJoystick, Rosant rosant) {
    super.onPanUpdate(details, customJoystick, rosant);
    RosantController.shoot(rosant, unitVector);
  }
}
