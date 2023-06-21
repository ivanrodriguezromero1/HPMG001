import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '/controllers/rosant_controller.dart';
import '/models/rosant/rosant.dart';
import '/models/rosant/rosant_direction.dart';

class RightArrowButton extends StatelessWidget {
  final Rosant _rosant;
  const RightArrowButton({required rosant, Key? key}) 
    : _rosant = rosant, super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 100,
        child: GestureDetector(
          onTapDown: (_) {
            _rosant.goingToWalkRight = true;
            _rosant.goingToWalkLeft = false;
            _rosant.direction = RosantDirection.right;
          },
          child: ElevatedButton( 
            onPressed: () {
              _rosant.goingToWalkRight = false;
              _rosant.goingToWalkLeft = false;
            },
            child: const Text('Botón'),
        ),
      ),
    );
  }
}