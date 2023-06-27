import 'package:flutter/material.dart';
import 'package:hpmg001/joysticks/joystick_detector.dart';
import '/joysticks/custom_joystick.dart';
import '/models/rosant/rosant.dart';
import 'joystick.dart';
import '/joysticks/joystick_element.dart';

class JoystickState extends State<Joystick> {
  late Rosant rosant;
  late CustomJoystick customJoystick;
  late JoystickDetector joystickDetector;
  @override
  void initState() {
    super.initState();
    rosant = widget.rosant;
    customJoystick = widget.customJoystick;
    joystickDetector = widget.joystickGestureDetector;
    customJoystick.defaultPosition();
  }
  @override
  Widget build(BuildContext context) {
    final baseOffset = customJoystick.calculateBaseOffset();
    final thumbOffset = customJoystick.calculateThumbOffset();
    return Positioned(
      top: customJoystick.top,
      left: customJoystick.left,
      child: SizedBox(
        width: customJoystick.width,
        height: customJoystick.height,
        child: Stack(
          children: [
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  joystickDetector.onPanStart(details, customJoystick);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  joystickDetector.onPanUpdate(details, customJoystick, rosant);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  joystickDetector.onPanEnd(details, customJoystick, rosant);
                });              
              },
              onTapUp: (details) {
                setState(() {
                  joystickDetector.onTapUp(details, customJoystick, rosant);
                });
              },
            ),
            JoystickElement(
              left: baseOffset.dx,
              top: baseOffset.dy,
              diameter: customJoystick.baseRadius*2,
              color: customJoystick.baseColor,
            ),
            JoystickElement(
              left: thumbOffset.dx,
              top: thumbOffset.dy,
              diameter: customJoystick.thumbRadius*2,
              color: customJoystick.thumbColor,
            ),
          ],
        ),
      ) 
    );
  }
}
