import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:hpmg001/models/controls/controls_units.dart';
import '/models/category_bits.dart';
import '/models/entity.dart';
import '/models/scenery/screen.dart';
import '/utils/globals.dart';

class ButtonShoot extends Entity {
  ButtonShoot();
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  double get width => _width;
  double get height => _height;
  @override
  void initializing(){
    _width = ControlsUnits.width;
    _height = ControlsUnits.height;
    _x = Screen.worldSize.x - 2*ControlsUnits.width;
    _y = Screen.worldSize.y - ControlsUnits.height;
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
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..friction = .6
      ..restitution = .4;
    final filter = Filter();
    filter.maskBits = CategoryBits.none;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = Paint()..color = const Color.fromARGB(255, 255, 255, 0);
    renderBody = false;
    priority = 16;
    final sprite = buttonPhysicalAttackSprite;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0,-.02),
      anchor: Anchor.topLeft,
      paint: Paint()..color = Color.fromRGBO(255, 255, 255, ControlsUnits.opacity)
    ));
  }
}