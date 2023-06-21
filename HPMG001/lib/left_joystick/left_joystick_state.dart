import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '/models/scenery/screen.dart';
import '/models/rosant/rosant.dart';
import '/left_joystick/left_joystick.dart';
import '/left_joystick/left_joystick_background.dart';

class LeftJoystickState extends State<LeftJoystick> {
  late Rosant rosant;
  late Vector2 screenSize; 
  late Offset startLocalPosition;
  late Offset currentLocalPosition;
  late double radius;

  @override
  void initState(){
    super.initState();
    rosant = widget.rosant;
    screenSize = Screen.worldSize*10;
    radius = 40;
    initialPosition();
  }
  @override
  Widget build(BuildContext context) {
    final offset = calculateOffset(startLocalPosition);
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
          LeftJoystickBackground(
            left: offset.dx, 
            top: offset.dy, 
            diameter: radius*2
          ),
        ],
      ),
    );
  }
  void initialPosition(){
    startLocalPosition = Offset(1.5*radius, 3*screenSize.y/4);
    currentLocalPosition = const Offset(0, 0);
  }
  Offset calculateOffset(Offset startPosition) {
    return Offset(
      (startPosition.dx - radius).clamp(radius, screenSize.x/2 - radius).toDouble(),
      (startPosition.dy - radius).clamp(radius, screenSize.y - radius).toDouble(),
    );
  }

}
