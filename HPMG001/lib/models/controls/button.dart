import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/controls/controls_units.dart';
import '/models/category_bits.dart';
import '/models/entity.dart';

class Button extends Entity {
  late Sprite sprite;
  late Vector2 position;
  late double _width;
  late double _height;
  late SpriteComponent _spriteComponent;
  double get width => _width;
  double get height => _height;
  @override
  void initializing() {
    _width = ControlsUnits.width;
    _height = ControlsUnits.height;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: position,
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
    renderBody = false;
    priority = 16;
    addSprite(1);
  }
  SpriteComponent createSpriteComponent(double opacity) {
    return SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0, 0),
      anchor: Anchor.topLeft,
      paint: Paint()..color = Color.fromRGBO(255, 255, 255, opacity)
    );
  }
  void addSprite(double opacity) {
    _spriteComponent = createSpriteComponent(opacity);
    add(_spriteComponent);
  }
  void updateSprite(double opacity) {
    remove(_spriteComponent);
    addSprite(opacity);
  }
}