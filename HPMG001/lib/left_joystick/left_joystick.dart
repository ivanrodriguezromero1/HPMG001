import 'package:flutter/material.dart';
import 'left_joystick_state.dart';
import '/models/rosant/rosant.dart';

class LeftJoystick extends StatefulWidget {
  final Rosant rosant;
  final Function performMovement;
  const LeftJoystick({
    required this.rosant, 
    required this.performMovement,
    Key? key}): super(key: key);
  @override
  LeftJoystickState createState() => LeftJoystickState();
}
