import 'package:flutter/material.dart';
import 'package:hpmg001/joysticks/custom_joystick.dart';
import 'package:hpmg001/joysticks/joystick_detector.dart';
import 'package:hpmg001/models/rosant/rosant.dart';

class JoystickDetectorImpl extends JoystickDetector {
  JoystickDetectorImpl() {
    unitVector = Offset.zero;
  }
  @override
  void onPanStart(DragStartDetails details, CustomJoystick customJoystick){
    customJoystick.baseCenter = Offset(
      details.localPosition.dx.clamp(customJoystick.baseCenterMinX, customJoystick.baseCenterMaxX),
      details.localPosition.dy.clamp(customJoystick.baseCenterMinY, customJoystick.baseCenterMaxY));
    customJoystick.thumbCenter = details.localPosition;
  }
  @override
  void onPanUpdate(DragUpdateDetails details, CustomJoystick customJoystick, Rosant rosant) {
    final currentPosition = details.localPosition;
    final positionDifference = currentPosition - customJoystick.baseCenter;
    final distance = positionDifference.distance;
    if(distance!=0) unitVector = positionDifference/distance;
    customJoystick.thumbCenter = customJoystick.baseCenter + unitVector*customJoystick.baseRadius;
  }
  @override
  void onPanEnd(DragEndDetails details, CustomJoystick customJoystick, Rosant rosant) {
    customJoystick.defaultPosition();
  }
  @override
  void onTapUp(TapUpDetails details, CustomJoystick customJoystick, Rosant rosant) {
    customJoystick.defaultPosition();
  }
}