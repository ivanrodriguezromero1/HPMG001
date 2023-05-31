import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/screen.dart';
import '../models/entity.dart';
import '../utils/globals.dart';
import '../models/direction.dart';

class Rosant extends Entity {
  late double _width;
  late double _height;
  late double _x;
  late double _y;
  late bool goingToWalkRight;
  late bool goingToWalkLeft;
  late Direction direction;
  double get width => _width;
  double get height => _height;
  @override
  void initializing(){
    _width = Screen.worldSize.x/20;
    _height = Screen.worldSize.y/5;
    _x = 1;
    _y = horizon;
    goingToWalkRight = false;
    goingToWalkLeft = false;
    direction = Direction.right;
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..setAsBoxXY(_width/2,_height/2);
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..friction = 0.5
      ..restitution = 0;
    final filter = Filter();
    filter.categoryBits = 0x0002;
    fixtureDef.filter = filter;
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