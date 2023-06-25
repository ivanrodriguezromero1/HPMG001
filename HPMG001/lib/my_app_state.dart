import 'dart:async';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
import 'package:flutter/material.dart';
import 'package:hpmg001/joysticks/left_joystick/left_custom_joystick.dart';
import 'package:hpmg001/joysticks/left_joystick/left_joystick_detector.dart';
import 'package:hpmg001/joysticks/right_joystick/right_custom_joystick.dart';
import 'package:hpmg001/joysticks/right_joystick/right_joystick_detector.dart';
import 'package:hpmg001/models/scenery/screen.dart';
import '/my_app.dart';
import 'joysticks/joystick.dart';
import 'game/epicron_stateless_widget.dart';

class MyAppState extends State<MyApp> {
  bool shouldRenderJoysticks = false;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      if (shouldRenderJoysticks) {
        t.cancel();
      } else {
        if (Screen.screenSize != Vector2.zero()) {
          setState(() {
            shouldRenderJoysticks = true;
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          EpicronStatelessWidget(rosant: widget.rosant),
          if(shouldRenderJoysticks)
            Joystick(
              rosant: widget.rosant,
              customJoystick: LeftCustomJoystick(),
              joystickGestureDetector: LeftJoystickDetector(),
            ),
          if(shouldRenderJoysticks)
            Joystick(
              rosant: widget.rosant,
              customJoystick: RightCustomJoystick(),
              joystickGestureDetector: RightJoystickGestureDetector(),
            ),  
        ],
    );
  }
}