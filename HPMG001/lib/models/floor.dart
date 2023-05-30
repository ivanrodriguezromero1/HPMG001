import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/entity.dart';
import '../models/screen.dart';
import '../utils/globals.dart';

class Floor extends Entity {
  Floor({required double x}):_x = x;
  late final double _x;
  late double _y;
  late double _width;
  late double _height;

  @override
  void initializing(){
    _width = 2*Screen.worldSize.x;
    _height = Screen.worldSize.y/3;
    _y = horizon;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2.zero(), Vector2(_width, 0));
    final fixtureDef = FixtureDef(shape)
      ..density = 100
      ..friction = 0.5
      ..restitution = 0;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // renderBody = false;
    // final sprite = floorSprite;
    // add(SpriteComponent(
    //   sprite: sprite,
    //   size: Vector2(_width, _height),
    //   position: Vector2(0,-.02),
    //   anchor: Anchor.topLeft
    // ));
  }
}