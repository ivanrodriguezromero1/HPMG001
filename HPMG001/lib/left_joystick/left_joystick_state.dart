import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '/models/scenery/screen.dart';
import '/models/rosant/rosant.dart';
import '/left_joystick/left_joystick.dart';
import 'left_joystick_element.dart';

class LeftJoystickState extends State<LeftJoystick> {
  late Rosant rosant;
  late Vector2 screenSize; 
  late Offset basePosition;
  late Offset thumbPosition;
  late double baseRadius;
  late double thumbRadius;
  @override
  void initState(){
    super.initState();
    rosant = widget.rosant;
    screenSize = Screen.worldSize*10;
    baseRadius = 45;
    thumbRadius = 30;
    defaultPosition();
  }
  @override
  Widget build(BuildContext context) {
    final baseOffset = calculateOffset(basePosition, baseRadius);
    final thumbOffset = calculateOffset(thumbPosition, thumbRadius);
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
            onPanUpdate: (details) {
              setState(() {
                final currentPosition = details.localPosition;
                final positionDifference = currentPosition - basePosition;
                final distance = positionDifference.distance;
                final unitVector = (distance!=0)? positionDifference/distance: const Offset(0, 0);
                thumbPosition = basePosition + unitVector*baseRadius;
              });
            },
            onPanEnd: (details) {
              setState(() {
                defaultPosition();
              });              
            },
            onTapUp: (details) {
              setState(() {
                defaultPosition();
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
    basePosition = Offset(1.5*baseRadius, 3*screenSize.y/4);
    thumbPosition = Offset(1.5*baseRadius, 3*screenSize.y/4);
  }
  Offset calculateOffset(Offset startPosition, double radius) {
    return Offset(
      (startPosition.dx - radius).clamp(baseRadius - radius, screenSize.x/2 - (baseRadius + radius)).toDouble(),
      (startPosition.dy - radius).clamp(baseRadius - radius, screenSize.y - (baseRadius + radius)).toDouble(),
    );
  }
}
