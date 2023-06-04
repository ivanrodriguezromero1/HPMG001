import 'dart:math';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '/models/rosant/rosant.dart';
import '/models/aliens/alien.dart';
import '/models/aliens/alien_direction.dart';
import '/models/projectile.dart';
import '/utils/globals.dart';
import '/models/scenery/screen.dart';

class AlienBullet extends Projectile {
  final Alien _alien;
  AlienBullet({required Alien alien}) :_alien = alien;
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  late AlienDirection _direction;
  @override
  void initializing(){
    _x = _alien.body.position.x;
    _y = _alien.body.position.y - _alien.height/10;
    _width = 0.1;
    _height = 0.1;
    _direction = _alien.direction;
    _alien.body.setTransform(_alien.body.position, 0);
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
      ..density = 5
      ..friction = 0.1
      ..restitution = 0.8;
    final filter = Filter();
    filter.categoryBits = 0x0005;
    filter.maskBits = 0xFFFF & ~0x0004 & ~0x0005;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = true;
    priority = 5;
    paint = Paint()..color = const Color.fromARGB(255, 123, 0, 255);
    body.gravityOverride = Vector2(0, 0);
    Vector2 force;
    double fx= 0.3;
    double fy = 0;
    switch(_direction){
      case AlienDirection.right:
        force = Vector2(fx, fy);
        break;
      case AlienDirection.left:
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
    if(other is Rosant){
      other.life--;
    }
  }
}