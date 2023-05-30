import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/screen.dart';
import '../models/entity.dart';

import '../utils/globals.dart';

class Rosant extends Entity {
  late double _width;
  late double _height;
  late double _x;
  late double _y;
  double get width => _width;
  double get height => _height;
  @override
  void initializing(){
    _width = Screen.worldSize.x/20;
    _height = Screen.worldSize.y/5;
    _x = 1;
    _y = Screen.worldSize.y/5;
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x,0) + Vector2(_width, _y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..setAsBoxXY(_width/2,_height/2);
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..friction = 0.5
      ..restitution = 0;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // renderBody = false;
    priority = 10;
    body.linearDamping = 1;
    // final walkAnimation = SpriteAnimation.spriteList(ingenierosSprites, stepTime: .08, loop: true);
    // add(SpriteAnimationComponent(
    //   animation: walkAnimation,
    //   size: Vector2(2*_width, 2*_height),
    //   position: Vector2(0,0.1),
    //   anchor: Anchor.center,
    //   removeOnFinish: false,
    // ));
  }
}