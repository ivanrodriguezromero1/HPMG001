import 'package:flutter/material.dart';

class JoystickElement extends StatelessWidget {
  final double left;
  final double top;
  final double diameter;
  final Color color;
  const JoystickElement({
    required this.left,
    required this.top,
    required this.diameter,
    required this.color,
    super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        ignoring: true,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: diameter,
              height: diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.18),
              ),              
            ),
            Container(
              width: diameter-2,
              height: diameter-2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),              
            ),
          ]
        ),
      ),
    );
  }
}