import 'dart:io';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:hpmg001/controllers/background_controller.dart';
import 'package:hpmg001/models/rosant/rosant.dart';
import '/models/entity.dart';
import '/models/scenery/screen.dart';
import '/utils/globals.dart';

class Background extends Entity {
  final Rosant _rosant;
  Background({required Rosant rosant}):_rosant = rosant;
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  double get width => _width;
  @override
  void initializing(){
    _x = 0;
    _y = 0;
    _width = 2*Screen.worldSize.x + 2;//49.83, 2*Screen.worldSize.x + 2
    _height = horizon;//2*Screen.worldSize.y/3
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2(-1, 0), Vector2(_width, 0));
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..friction = 0.2
      ..restitution = .4;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    final sprite = backgroundSprite;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0,0),
      anchor: Anchor.topLeft
    ));
  }
  @override
  void update(double dt){
    super.update(dt);
    BackgroundController.move(this, _rosant);
  }
}