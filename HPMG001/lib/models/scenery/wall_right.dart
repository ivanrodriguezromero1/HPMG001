import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/rosant/rosant.dart';
import '/models/category_bits.dart';
import '/models/scenery/screen.dart';
import '/models/entity.dart';

class WallRight extends Entity with ContactCallbacks {
  late double _x;
  late double _y;
  late double _width;
  late double _height;

  @override
  void initializing(){
    _height = Screen.worldSize.y;
    _width = 2*Screen.worldSize.x;
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
    final shape = EdgeShape()..set(
      Vector2(_width, 0), Vector2(_width, _height));
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
    renderBody = false;
    // priority = 16;
  }
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
      if(other is Rosant){
        
      }
  }

}