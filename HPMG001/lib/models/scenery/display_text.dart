import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '/models/entity.dart';

class DisplayText extends Entity {
  final double _x;
  final double _y;
  DisplayText({required double x, required double y}): _x = x, _y = y ;
  late TextComponent textComponent;
  late double _xScale;
  late double _yScale;
  late double _fontSize;
  
  @override
  void initializing(){
    _xScale = 0.5;
    _yScale = 0.5;
    _fontSize = 5;
    textComponent = TextComponent(
      position: Vector2.zero(),
      text: '0',
      textRenderer: TextPaint(
        style: TextStyle(color:const Color.fromARGB(255, 255, 255, 255), fontSize: _fontSize)
      ),
    )..scale = Vector2(_xScale, _yScale);
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.static,
    );
    return world.createBody(bodyDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // renderBody = false;
    add(textComponent);
    priority = 15;
  }
}