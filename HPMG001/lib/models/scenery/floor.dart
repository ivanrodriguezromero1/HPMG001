import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/entity.dart';
import '/models/scenery/screen.dart';
import '/utils/globals.dart';

class Floor extends Entity {
  late double _x;
  late double _y;
  late double _width;
  late double _height;

  @override
  void initializing(){
    _x = 0;
    _y = horizon;
    _width = 2*Screen.worldSize.x + 2;
    _height = Screen.worldSize.y/3;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2(-1,0), Vector2(_width, 0));
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