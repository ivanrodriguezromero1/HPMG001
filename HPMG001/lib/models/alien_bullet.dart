import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '../models/alien.dart';
import '../models/direction.dart';
import '../models/rosant.dart';
import '../models/projectile.dart';
import '../utils/globals.dart';
import '../models/screen.dart';

class AlienBullet extends Projectile {
  final Alien _rosant;
  AlienBullet({required rosant}) :_rosant = rosant;
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
    _rosant.body.setTransform(_rosant.body.position, 0);
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
      ..density = 100
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
    priority = 5;
    paint = Paint()..color = const Color.fromARGB(255, 255, 0, 0);
    body.gravityOverride = Vector2(0, 0);
    Vector2 force;
    double fx= 12;
    double fy = 0;
    switch(_direction){
      case Direction.right:
        force = Vector2(fx, fy);
        break;
      case Direction.left:
        force = Vector2(-fx, fy);
        break;
      default:
        force = Vector2(fx, fy);
        break;
    }    
    body.applyLinearImpulse(force);
  }
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if(other is Alien){
      other.life--;
    }
  }
}