import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '/models/entity.dart';

class DisplayText extends Entity {
  late double _x;
  late double _y;
  DisplayText({required double x, required double y}): _x = x, _y = y ;
  late TextComponent textComponent;
  late double _xScale;
  late double _yScale;
  late double _fontSize;
  
  @override
  void initializing(){
    _xScale = 0.4;
    _yScale = 0.4;
    _fontSize = 0.5;
    textComponent = TextComponent(
      position: Vector2.zero(),
      text: '0',
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: _fontSize)
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
    final shape = PolygonShape()..setAsBoxXY(0,0);
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..restitution = .1;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // renderBody = false;
    add(textComponent);
    priority = 15;
  }
}