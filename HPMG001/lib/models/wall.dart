import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/screen.dart';
import '../models/entity.dart';

class Wall extends Entity {
  late double _x;
  late double _y;
  late double _height;
  
  @override
  void initializing(){
    _height = Screen.worldSize.y;
    _x = 0;
    _y = 0;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );
    final shape1 = EdgeShape()..set(Vector2(0.01,0), Vector2(0.01, _height));
    final fixtureDef1 = FixtureDef(shape1)
      ..density=10
      ..restitution=.01;
    final shape2 = EdgeShape()..set(Vector2(Screen.worldSize.x - 0.01, 0), Vector2(Screen.worldSize.x - 0.01, _height));
    final fixtureDef2 = FixtureDef(shape2)
      ..density=10
      ..restitution=.01;
    return world.createBody(bodyDef)..createFixture(fixtureDef1)..createFixture(fixtureDef2);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // renderBody = false;
  }
}