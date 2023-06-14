import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/scenery/screen.dart';
import 'rosant_units.dart';
import '/models/category_bits.dart';
import '/models/entity.dart';
import '/utils/globals.dart';
import '/models/rosant/rosant_direction.dart';

class Rosant extends Entity {
  late double _width;
  late double _height;
  late double _x;
  late double _y;
  late bool goingToWalkRight;
  late bool goingToWalkLeft;
  late RosantDirection direction;
  late int life;
  late int numberOfDeadAliens;
  late WeldJoint joint;
  late bool canJump;
  late bool goingToJump;
  double get width => _width;
  double get height => _height;

  @override
  void initializing(){
    _width = RosantUnits.width;
    _height = RosantUnits.height;
    _x = 5;
    _y = Globals.horizon - _height - 0.04;
    goingToWalkRight = false;
    goingToWalkLeft = false;
    direction = RosantDirection.right;
    life = 40;
    numberOfDeadAliens = 0;
    canJump = false;
    goingToJump = false;
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..set(
      [Vector2(0, 0),
      Vector2(_width , 0),
      Vector2(_width , _height),
      Vector2(0, _height)]);
    // final shape = CircleShape()..radius = _height/4;
    final fixtureDef = FixtureDef(shape)
      ..density = 0.4
      ..friction = 0.3
      ..restitution = 0;
    final filter = Filter();
    filter.categoryBits = CategoryBits.rosant;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 10;
    body.linearDamping = 1;
    // body.gravityOverride = Vector2(0, 0);
    final sprite = Globals.rosantRightSprite;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0, 0),
      anchor: Anchor.topLeft
    ));
    // final walkAnimation = SpriteAnimation.spriteList(ingenierosSprites, stepTime: .08, loop: true);
    // add(SpriteAnimationComponent(
    //   animation: walkAnimation,
    //   size: Vector2(2*_width, 2*_height),
    //   position: Vector2(0,0.1),
    //   anchor: Anchor.center,
    //   removeOnFinish: false,
    // ));

  }
  @override
  void update(double dt){
    super.update(dt);
    if(life<=0){
      destroyBody();
    }
  }
}