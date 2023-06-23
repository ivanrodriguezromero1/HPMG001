import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '/models/scenery/screen.dart';
import '/models/rosant/rosant.dart';
import '/left_joystick/left_joystick.dart';
import 'left_joystick_element.dart';

class LeftJoystickState extends State<LeftJoystick> {
  late Rosant rosant;
  late Function performMovement;
  late Vector2 screenSize; 
  late Offset basePosition;
  late Offset thumbPosition;
  late double baseRadius;
  late double thumbRadius;
  @override
  void initState(){
    super.initState();
    rosant = widget.rosant;
    performMovement = widget.performMovement;
    screenSize = Screen.worldSize*10;
    baseRadius = 45;
    thumbRadius = 30;
    defaultPosition();
  }
  @override
  Widget build(BuildContext context) {
    final baseOffset = calculateBaseOffset();
    final thumbOffset = calculateThumbOffset();
    return SizedBox(
      width: screenSize.x / 2,
      height: screenSize.y,
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (details) {
              setState(() {
                basePosition = details.localPosition;
                thumbPosition = details.localPosition;
              });
            },
            onPanStart: (details) {
              setState(() {
                basePosition = details.localPosition;
                thumbPosition = details.localPosition;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                final currentPosition = details.localPosition;
                final positionDifference = currentPosition - basePosition;
                final distance = positionDifference.distance;
                final unitVector = (distance!=0)? positionDifference/distance: const Offset(0, 0);
                thumbPosition = basePosition + unitVector*baseRadius;
                performMovement(rosant, unitVector:unitVector);
              });
            },
            onPanEnd: (details) {
              setState(() {
                defaultPosition();
                performMovement(rosant);
              });              
            },
            onTapUp: (details) {
              setState(() {
                defaultPosition();
                performMovement(rosant);
              });
            },
          ),
          LeftJoystickElement(
            left: baseOffset.dx,
            top: baseOffset.dy,
            diameter: baseRadius*2,
            color: const Color.fromRGBO(58, 42, 51, 0.35),
          ),
          LeftJoystickElement(
            left: thumbOffset.dx,
            top: thumbOffset.dy,
            diameter: thumbRadius*2,
            color: const Color.fromRGBO(58, 42, 51, 0.60),
          ),
        ],
      ),
    );
  }
  void defaultPosition(){
    basePosition = Offset(baseRadius + thumbRadius, 3*screenSize.y/4);
    thumbPosition = Offset(baseRadius + thumbRadius, 3*screenSize.y/4);
  }
  Offset calculateBaseOffset() {
    return Offset(
      (basePosition.dx - baseRadius).clamp(thumbRadius, screenSize.x/2 - (2*baseRadius + thumbRadius)).toDouble(),
      (basePosition.dy - baseRadius).clamp(thumbRadius, screenSize.y - (2*baseRadius + thumbRadius)).toDouble(),
    );
  }
  Offset calculateThumbOffset() {
    return Offset(
      (thumbPosition.dx - thumbRadius).clamp(0, screenSize.x/2 - (2*thumbRadius)).toDouble(),
      (thumbPosition.dy - thumbRadius).clamp(0, screenSize.y - (2*thumbRadius)).toDouble(),
    );
  }
}
