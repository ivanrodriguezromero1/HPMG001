import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:hpmg001/models/controls/controls_units.dart';
import '/models/category_bits.dart';
import '/models/entity.dart';
import '/models/scenery/screen.dart';
import '/utils/globals.dart';

class ButtonJump extends Entity {
  ButtonJump();
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  double get width => _width;
  double get height => _height;
  @override
  void initializing(){
    _width = 2*ControlsUnits.width;
    _height = 2*ControlsUnits.height;
    _x = Screen.worldSize.x - 4*ControlsUnits.width;
    _y = Screen.worldSize.y - 2*ControlsUnits.height;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );
    final shape = PolygonShape()..set(
      [Vector2(0,0),
      Vector2(_width , 0), 
      Vector2(_width , _height), 
      Vector2(0, _height)]);
    final fixtureDef = FixtureDef(shape);
    final filter = Filter();
    filter.maskBits = CategoryBits.none;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = Paint()..color = const Color.fromARGB(255, 0, 255, 0);
    renderBody = false;
    priority = 16;
    final sprite = buttonJumpSprite;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0,-.02),
      anchor: Anchor.topLeft,
      paint: Paint()..color = const Color.fromRGBO(255, 255, 255, 0.4)
    ));
  }
}