import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/category_bits.dart';
import '/models/scenery/screen.dart';
import '/models/entity.dart';

class WallLeft extends Entity with ContactCallbacks {
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
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );
    final shape = EdgeShape()..set(Vector2(0, 0), Vector2(0, _height));
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..restitution = 0.01;
    final filter = Filter();
    filter.maskBits = CategoryBits.all & ~CategoryBits.alien;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // renderBody = false;
  }

}