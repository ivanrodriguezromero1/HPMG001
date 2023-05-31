import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/entity.dart';
import '../models/screen.dart';
import '../utils/globals.dart';

class JoystickLeft extends Entity {
  JoystickLeft();
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  double get width => _width;
  double get height => _height;
  @override
  void initializing(){
    _width = Screen.worldSize.x/4;
    _height = Screen.worldSize.y/4;    
    _x = 0;
    _y = Screen.worldSize.y - _height;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );
    final shape = PolygonShape()..set(
      [Vector2(0,0),
      Vector2(_width , 0), 
      Vector2(_width , _height), 
      Vector2(0, _height)]);
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..friction = .6
      ..restitution = .4;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = Paint()..color = const Color.fromARGB(255, 0, 0, 255);
    // renderBody = false;
    // final sprite = backdropSprite;
    // add(SpriteComponent(
    //   sprite: sprite,
    //   size: Vector2(_width, _height),
    //   position: Vector2(0,-.02),
    //   anchor: Anchor.topLeft
    // ));
  }
}