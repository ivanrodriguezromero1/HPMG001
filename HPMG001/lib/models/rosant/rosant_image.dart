import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:hpmg001/models/rosant/rosant.dart';
import 'rosant_units.dart';
import '/models/category_bits.dart';
import '/models/entity.dart';
import '/utils/globals.dart';
import 'rosant_direction.dart';

class RosantImage extends Entity {
  final Rosant _rosant;
  RosantImage({required Rosant rosant}): _rosant = rosant;
  late double _width;
  late double _height;
  late double _x;
  late double _y;
  late SpriteComponent spriteComponent;

  double get width => _width;
  double get height => _height;
  @override
  void initializing(){
    _width = RosantUnits.width;
    _height = RosantUnits.height;
    _x = 2;
    _y = horizon - _height - 0.04;
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );
    final shape = PolygonShape()..set(
      [Vector2(0, 0),
      Vector2(_width , 0),
      Vector2(_width , _height),
      Vector2(0, _height)]);
    // final shape = CircleShape()..radius = _width;
    final fixtureDef = FixtureDef(shape)
      ..density = 0.7
      ..friction = 0.05
      ..restitution = 0;
    final filter = Filter();
    // filter.categoryBits = CategoryBits.rosant;
    filter.maskBits = CategoryBits.none;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 11;
    body.linearDamping = 0;
    // body.gravityOverride = Vector2(0, 0);
    // final sprite = rosantSprite;
    // add(SpriteComponent(
    //   sprite: sprite,
    //   size: Vector2(_width, _height),
    //   position: Vector2(0, 0),
    //   anchor: Anchor.center
    // ));
    spriteComponent = createSpriteComponent(rosantRightSprite);
    add(spriteComponent);
    // final walkAnimation = SpriteAnimation.spriteList(ingenierosSprites, stepTime: .08, loop: true);
    // add(SpriteAnimationComponent(
    //   animation: walkAnimation,
    //   size: Vector2(2*_width, 2*_height),
    //   position: Vector2(0,0.1),
    //   anchor: Anchor.center,
    //   removeOnFinish: false,
    // ));
  }
  SpriteComponent createSpriteComponent(Sprite sprite) {
    return SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0, -_height/4),
      anchor: Anchor.center,
    );
  }
  @override
  void update(double dt){
    super.update(dt);
    if(_rosant.life <= 0){
      destroyBody();
    }
    body.setTransform(_rosant.body.position, body.angle);
    if(_rosant.goingToWalkRight){
      remove(spriteComponent);
      spriteComponent = createSpriteComponent(rosantRightSprite);
      add(spriteComponent);
    } else if(_rosant.goingToWalkLeft){
      remove(spriteComponent);
      spriteComponent = createSpriteComponent(rosantLeftSprite);
      add(spriteComponent);
    }
  }
}