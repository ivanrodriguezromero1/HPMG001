import 'package:flutter/material.dart';
import 'package:hpmg001/controllers/rosant_controller.dart';
import 'package:hpmg001/joysticks/custom_joystick.dart';
import 'package:hpmg001/joysticks/joystick_detector_impl.dart';
import 'package:hpmg001/models/rosant/rosant.dart';
import 'package:hpmg001/models/rosant/rosant_bullet.dart';

class RightJoystickDetector extends JoystickDetectorImpl {
  @override
  void onPanUpdate(DragUpdateDetails details, CustomJoystick customJoystick, Rosant rosant) {
    super.onPanUpdate(details, customJoystick, rosant);
    double x = RosantController.calculateBulletXPosition(rosant);
    double y = RosantController.calculateBulletYPosition(rosant);
    rosant.gameRef.add(
      RosantBullet(
        x: x,
        y: y,
        unitVector: unitVector,
      )
    );
  }
}
