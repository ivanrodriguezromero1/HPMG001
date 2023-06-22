import 'dart:async';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
import 'package:flutter/material.dart';
import 'package:hpmg001/models/scenery/screen.dart';
import '/my_app.dart';
import '/left_joystick/left_joystick.dart';
import '/game/epicron_stateless_widget.dart';

class MyAppState extends State<MyApp> {
  bool shouldRenderLeftJoystick = false;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      if (shouldRenderLeftJoystick) {
        t.cancel();
      } else {
        if (Screen.worldSize != Vector2.zero()) {
          setState(() {
            shouldRenderLeftJoystick = true;
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
          if(shouldRenderLeftJoystick)
            LeftJoystick(
              rosant: widget.rosant,
              myFunction: widget.performMovement
            ),
        ],
    );
  }
}