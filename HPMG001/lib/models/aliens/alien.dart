import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '/models/aliens/alien_bullet.dart';
import '/models/aliens/alien_direction.dart';
import '/models/aliens/alien_units.dart';
import '/models/category_bits.dart';
import '/models/aliens/alien_configuration.dart';
import '/models/aliens/alien_factory.dart';
import '/models/scenery/display_text.dart';
import '/models/rosant/rosant.dart';
import '/controllers/alien_controller.dart';
import '/models/scenery/screen.dart';
import '/models/entity.dart';
import '/utils/globals.dart';
import '../../utils/character_state.dart';

class Alien extends Entity with ContactCallbacks {
  final Rosant _rosant;
  Alien({required rosant}): _rosant = rosant;
  late double _width;
  late double _height;
  late double _x;
  late double _y;
  late AlienDirection direction;
  late int life;
  late bool isFallen;
  late double elapsedTimeSinceFall;
  late double elapsedTimeSinceContact;
  late bool isContacted;
  late DisplayText displayAlienLife;
  late AlienConfiguration alienConfiguration;

  double get width => _width;
  double get height => _height;

  @override
  void initializing() {
    alienConfiguration = AlienFactory.createRandomAlien();
    _width = alienConfiguration.width;
    _height = alienConfiguration.height;
    life = alienConfiguration.life;
    _x = (Random().nextInt(2) == 0) ? Screen.worldSize.x : 0;
    _y = alienConfiguration.y;
    direction = AlienDirection.left;
    elapsedTimeSinceFall = 0;
    isFallen = false;
    elapsedTimeSinceContact = 0;
    isContacted = false;
    displayAlienLife = DisplayText(x: 0, y: -_height/4.5);
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..set(
      [Vector2(0, 0),
      Vector2(_width/4 , 0), 
      Vector2(_width/4 , _height), 
      Vector2(0, _height)]);
    final fixtureDef = FixtureDef(shape)
      ..density = alienConfiguration.density
      ..friction = 0.1
      ..restitution = 0;
    final filter = Filter();
    filter.categoryBits = CategoryBits.alien;
    filter.maskBits = ~CategoryBits.alien;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 10;
    body.linearDamping = 10;
    body.angularDamping = 1000;
    paint = Paint()..color = const Color.fromARGB(255, 136, 0, 255);
    // body.gravityOverride = alienConfiguration.gravity;
    body.gravityOverride = Vector2.zero();
    add(displayAlienLife);
    final sprite = alienConfiguration.sprite;
    add(SpriteComponent(
      sprite: sprite,
      position: Vector2(-3*_width/8, 0),
      size: Vector2(_width, _height),
      anchor: Anchor.topLeft
    ));
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
  void update(double dt) {
    super.update(dt);
    if(life<=0){
      _rosant.numberOfDeadAliens++;
      destroyBody();
    }
    AlienController.walk(this, _rosant);
    AlienController.standUp(this, dt);
    AlienController.contact(this, _rosant, dt);
    AlienController.fallenOut(this);
    displayAlienLife.textComponent.text = '$life';
  }
}