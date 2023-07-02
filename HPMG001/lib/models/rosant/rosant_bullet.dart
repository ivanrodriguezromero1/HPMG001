import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:hpmg001/models/rosant/rosant_units.dart';
import 'package:hpmg001/utils/horizontal_orientation.dart';
import '/models/category_bits.dart';
import '/utils/globals.dart';
import '/models/aliens/alien.dart';
import '../../utils/character_state.dart';
import '/models/projectile.dart';

class RosantBullet extends Projectile {
  final double x;
  final double y;
  final Offset unitVector;
  RosantBullet({
    required this.x,
    required this.y,
    required this.unitVector
  });
  late double _width;
  late double _height;
  @override
  void initializing(){
    // _x = _rosant.body.position.x + _rosant.width/2;
    // _y = _rosant.body.position.y + _rosant.height/4;
    _width = RosantUnits.width/10;
    _height = RosantUnits.height/20;
    // _rosant.body.setTransform(_rosant.body.position, 0);
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(x, y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..setAsBoxXY(_width, _height);
    final fixtureDef = FixtureDef(shape)
      ..density = 20
      ..friction = 0.1
      ..restitution = 0.8;
    final filter = Filter();
    filter.categoryBits = CategoryBits.rosantBullet;
    filter.maskBits = ~CategoryBits.rosantBullet;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 11;
    paint = Paint()..color = const Color.fromARGB(255, 255, 0, 0);
    add(SpriteComponent(
      sprite: Globals.bulletSprite,
      size: Vector2(2*_width, 2*_height),
      anchor: Anchor.center
    ));
    body.gravityOverride = Vector2(0, 0);
    Vector2 force;
    double magnitude = 2000;
    force = Vector2(unitVector.dx, unitVector.dy)*magnitude;
    body.applyLinearImpulse(force);
  }
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if(other is Alien){
      if(other.life >= 1){
        other.life--;
      }
    }
  }
 
}