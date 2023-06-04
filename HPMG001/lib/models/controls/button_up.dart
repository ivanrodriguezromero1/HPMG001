import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/entity.dart';
import '/models/scenery/screen.dart';
import '/utils/globals.dart';

class ButtonUp extends Entity {
  ButtonUp();
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  double get width => _width;
  double get height => _height;
  @override
  void initializing(){
    _height = buttonUnit;
    _width = buttonUnit;    
    _x = buttonUnit;
    _y = Screen.worldSize.y - 3*buttonUnit;
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
    renderBody = false;
    final sprite = upArrowSprite;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0, 0),
      anchor: Anchor.topLeft,
      paint: Paint()..color = const Color.fromRGBO(255, 255, 255, 0.5)
    ));
  }
}