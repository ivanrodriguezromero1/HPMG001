import 'package:flutter/material.dart';
import 'package:hpmg001/controllers/rosant_controller.dart';
import 'package:hpmg001/joysticks/custom_joystick.dart';
import 'package:hpmg001/joysticks/joystick_gesture_detector.dart';
import 'package:hpmg001/models/rosant/rosant.dart';

class LeftJoystickDetector extends JoystickDetector {
  @override
  void onTapDown(TapDownDetails details, CustomJoystick customJoystick) {
    customJoystick.basePosition = Offset(
      details.localPosition.dx.clamp(customJoystick.baseMinX, customJoystick.baseMaxX),
      details.localPosition.dy.clamp(customJoystick.baseMinY, customJoystick.baseMaxY));
    customJoystick.thumbPosition = details.localPosition;
  }
  @override
  void onPanStart(DragStartDetails details, CustomJoystick customJoystick){
    customJoystick.basePosition = Offset(
      details.localPosition.dx.clamp(customJoystick.baseMinX, customJoystick.baseMaxX),
      details.localPosition.dy.clamp(customJoystick.baseMinY, customJoystick.baseMaxY));
    customJoystick.thumbPosition = details.localPosition;
  }
  @override
  void onPanUpdate(DragUpdateDetails details, CustomJoystick customJoystick, Rosant rosant) {
    final currentPosition = details.localPosition;
    final positionDifference = currentPosition - customJoystick.basePosition;
    final distance = positionDifference.distance;
    final unitVector = (distance!=0)? positionDifference/distance: const Offset(0, 0);
    customJoystick.thumbPosition = customJoystick.basePosition + unitVector*customJoystick.baseRadius;
    RosantController.performMovement(rosant, unitVector: unitVector);
  }
  @override
  void onPanEnd(DragEndDetails details, CustomJoystick customJoystick, Rosant rosant) {
    customJoystick.defaultPosition();
    RosantController.performMovement(rosant);
  }
  @override
  void onTapUp(TapUpDetails details, CustomJoystick customJoystick, Rosant rosant) {
    customJoystick.defaultPosition();
    RosantController.performMovement(rosant);
  }
    
}