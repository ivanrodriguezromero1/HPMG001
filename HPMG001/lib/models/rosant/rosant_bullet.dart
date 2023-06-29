import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '/models/category_bits.dart';
import '/utils/globals.dart';
import '/models/aliens/alien.dart';
import '../../utils/character_state.dart';
import '/models/rosant/rosant.dart';
import '/models/projectile.dart';

class RosantBullet extends Projectile {
  final Rosant _rosant;
  RosantBullet({required Rosant rosant}) :_rosant = rosant;
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  late CharacterState _state;
  @override
  void initializing(){
    _x = _rosant.body.position.x + _rosant.width/2;
    _y = _rosant.body.position.y + _rosant.height/4;
    _width = 1;
    _height = 0.8;
    _state = _rosant.state;
    // _rosant.body.setTransform(_rosant.body.position, 0);
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
      ..density = 20
      ..friction = 0.1
      ..restitution = 0.8;
    final filter = Filter();
    filter.categoryBits = CategoryBits.rosantBullet;
    filter.maskBits = CategoryBits.all & ~CategoryBits.rosant & ~CategoryBits.rosantBullet;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 5;
    paint = Paint()..color = const Color.fromARGB(255, 255, 0, 0);
    add(SpriteComponent(
      sprite: Globals.stoneSprite,
      size: Vector2(2*_width, 2*_height),
      anchor: Anchor.center
    ));
    body.gravityOverride = Vector2(0, 98.1);
    Vector2 force;
    double magnitudeX = 6000;
    double magnitudeY = -2000;
    switch(_state){
      case CharacterState.idleRight:
        force = Vector2(magnitudeX, magnitudeY);
        break;
      default:
        force = Vector2(-magnitudeX, magnitudeY);
        break;
      // default:
      //   force = Vector2(-2000, -magnitudeX);
      //   break;
    }
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