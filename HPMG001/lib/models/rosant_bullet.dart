import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/models/direction.dart';
import 'package:juego_ingeniero/models/rosant.dart';
import '../models/projectile.dart';
import '../utils/globals.dart';
import '../models/screen.dart';

class RosantBullet extends Projectile {
  final Rosant _rosant;
  RosantBullet({required rosant}) :_rosant = rosant;
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  late Direction _direction;
  @override
  void initializing(){
    _x = _rosant.body.position.x;
    _y = _rosant.body.position.y - _rosant.height/5;
    _width = 0.06;
    _height = 0.06;
    _direction = _rosant.direction;
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..setAsBoxXY(_width, _height);
    final fixtureDef = FixtureDef(shape)
      ..density = 50
      ..friction = 0.1
      ..restitution = 0.8;
    final filter = Filter();
    filter.maskBits = 0xFFFF & ~0x0002;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = true;
    priority = 10;
    paint = Paint()..color = const Color.fromARGB(255, 255, 0, 0);
    body.linearDamping = 0;
    Vector2 force;
    switch(_direction){
      case Direction.right:
        force = Vector2(25, -1);break;
      case Direction.left:
        force = Vector2(-25, -1);break;
      default:
        force = Vector2(25, -1);break;
    }    
    body.applyLinearImpulse(force);
  }
}