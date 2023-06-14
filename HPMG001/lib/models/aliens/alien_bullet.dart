import 'dart:math';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:hpmg001/models/aliens/alien_units.dart';
import 'package:hpmg001/models/category_bits.dart';
import 'package:hpmg001/models/scenery/display_text.dart';
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
  void initializing() {
    _x = _alien.body.position.x + _alien.width/2;
    _y = _alien.body.position.y + _alien.height/3;
    _width = 1;
    _height = 1;
    _direction = _alien.direction;
    _alien.body.setTransform(_alien.body.position, 0);
  }
  @override
  Body createBody() {
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
    filter.categoryBits = CategoryBits.alienBullet;
    filter.maskBits = CategoryBits.all & ~CategoryBits.alien & ~CategoryBits.alienBullet;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = true;
    priority = 5;
    paint = Paint()..color = const Color.fromARGB(255, 229, 255, 0);
    body.gravityOverride = Vector2(0, 0);
    Vector2 force;
    double magnitude= 400;
    switch(_direction){
      case AlienDirection.right:
        force = Vector2(magnitude, 0);
        break;
      case AlienDirection.left:
        force = Vector2(-magnitude, 0);
        break;
      default:
        force = Vector2(0, magnitude);
        break;
    }    
    body.applyLinearImpulse(force);
  }
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if(other is Rosant){
      if(other.life >= 1){
        other.life--;
      }
    }
  }

}