import 'package:flutter/material.dart';

class LeftJoystickElement extends StatelessWidget {
  final double left;
  final double top;
  final double diameter;
  const LeftJoystickElement({
    required this.left,
    required this.top,
    required this.diameter,
    super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        ignoring: true,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}