import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/models/alien_configuration.dart';
import 'package:juego_ingeniero/models/alien_factory.dart';
import 'package:juego_ingeniero/models/display_text.dart';
import 'package:juego_ingeniero/models/rosant.dart';
import '../controllers/alien_controller.dart';
import '../models/screen.dart';
import '../models/entity.dart';
import '../utils/globals.dart';
import '../models/direction.dart';

class Alien extends Entity with ContactCallbacks {
  final Rosant _rosant;
  Alien({required rosant}): _rosant = rosant;
  late double _width;
  late double _height;
  late double _x;
  late double _y;
  late bool goingToWalkRight;
  late bool goingToWalkLeft;
  late Direction direction;
  late int life;
  late bool isFallen;
  late double elapsedTimeSinceFall;
  late double elapsedTimeSinceContact;
  late bool isContacted;
  late DisplayText displayAlienLife;
  double get height => _height;
  
  @override
  void initializing(){
    AlienConfiguration alienConfiguration = AlienFactory.createRandomAlien();
    _width = alienConfiguration.width;
    _height = alienConfiguration.height;
    life = alienConfiguration.life;
    _x = Random().nextInt(2) == 0 ? Screen.worldSize.x : 0;
    _y = horizon - _height/2;    
    goingToWalkRight = false;
    goingToWalkLeft = false;
    direction = Direction.right;
    elapsedTimeSinceFall = 0;
    isFallen = false;
    elapsedTimeSinceContact = 0;
    isContacted = false;
    displayAlienLife = DisplayText(x: 0, y: 0);
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..setAsBoxXY(_width/2,_height/2);
    final fixtureDef = FixtureDef(shape)
      ..density = 100
      ..friction = 0.3
      ..restitution = 0;
    final filter = Filter();
    filter.categoryBits = 0x0003;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // renderBody = false;
    priority = 10;
    body.linearDamping = 20;
    paint = Paint()..color = const Color.fromARGB(255, 136, 0, 255);
    add(displayAlienLife);
    // final walkAnimation = SpriteAnimation.spriteList(ingenierosSprites, stepTime: .08, loop: true);
    // add(SpriteAnimationComponent(
    //   animation: walkAnimation,
    //   size: Vector2(2*_width, 2*_height),
    //   position: Vector2(0,0.1),
    //   anchor: Anchor.center,
    //   removeOnFinish: false,
    // ));
  }
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if(other is Rosant){
      isContacted = true;
      if(other.life >= 1){
        other.life--;
      }
    }
  }
  @override
  void endContact(Object other, Contact contact) {
    super.endContact(other, contact);
    if(other is Rosant){
      isContacted = false;
    }
  }
  @override
  void update(double dt){
    super.update(dt);
    if(life<=0){
      _rosant.numberOfDeadAliens++;
      destroyBody();
    }
    AlienController.walk(this, _rosant);
    AlienController.standUp(this, dt);
    AlienController.contact(this, _rosant, dt);
    displayAlienLife.textComponent.text = '$life';
  }
}