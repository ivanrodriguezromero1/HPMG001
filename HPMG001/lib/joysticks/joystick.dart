import 'package:flutter/material.dart';
import 'package:hpmg001/joysticks/custom_joystick.dart';
import 'package:hpmg001/joysticks/joystick_detector.dart';
import 'joystick_state.dart';
import '/models/rosant/rosant.dart';

class Joystick extends StatefulWidget {
  final Rosant rosant;
  final CustomJoystick customJoystick;
  final JoystickDetector joystickGestureDetector;
  const Joystick({
    required this.rosant,
    required this.customJoystick,
    required this.joystickGestureDetector,
    Key? key}): super(key: key);
  @override
  JoystickState createState() => JoystickState();

}
