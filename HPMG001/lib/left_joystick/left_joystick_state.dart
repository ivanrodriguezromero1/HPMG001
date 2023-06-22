import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '/models/scenery/screen.dart';
import '/models/rosant/rosant.dart';
import '/left_joystick/left_joystick.dart';
import 'left_joystick_element.dart';

class LeftJoystickState extends State<LeftJoystick> {
  late Rosant rosant;
  late Vector2 screenSize; 
  late Offset startLocalPosition;
  late Offset currentLocalPosition;
  late double baseRadius;
  late double thumbRadius;
  @override
  void initState(){
    super.initState();
    rosant = widget.rosant;
    screenSize = Screen.worldSize*10;
    baseRadius = 50;
    thumbRadius = 25;
    initialPosition();
  }
  @override
  Widget build(BuildContext context) {
    final baseOffset = calculateOffset(startLocalPosition, baseRadius);
    final thumbOffset = calculateOffset(startLocalPosition, thumbRadius);
    return SizedBox(
      width: screenSize.x / 2,
      height: screenSize.y,
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (details) {
              setState(() {
                startLocalPosition = details.localPosition;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                currentLocalPosition = details.localPosition;
              });
            },
            onPanEnd: (details) {
              setState(() {
                initialPosition();
              });              
            },
            onTapUp: (details) {
              setState(() {
                initialPosition();
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
  void initialPosition(){
    startLocalPosition = Offset(1.5*baseRadius, 3*screenSize.y/4);
    currentLocalPosition = const Offset(0, 0);
  }
  Offset calculateOffset(Offset startPosition, double radius) {
    return Offset(
      (startPosition.dx - radius).clamp(baseRadius - radius, screenSize.x/2 - (baseRadius + radius)).toDouble(),
      (startPosition.dy - radius).clamp(baseRadius - radius, screenSize.y - (baseRadius + radius)).toDouble(),
    );
  }
}
