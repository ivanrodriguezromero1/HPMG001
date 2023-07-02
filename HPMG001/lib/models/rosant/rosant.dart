import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/widgets.dart';
import 'package:hpmg001/controllers/rosant_controller.dart';
import 'package:hpmg001/utils/horizontal_orientation.dart';
import 'package:hpmg001/utils/animations.dart';
import 'package:hpmg001/utils/camera.dart';
import 'package:hpmg001/utils/globals.dart';
import '/models/scenery/screen.dart';
import '/models/rosant/rosant_units.dart';
import '/models/category_bits.dart';
import '/models/entity.dart';
import '../../utils/character_state.dart';

class Rosant extends Entity {
  Rosant() {
    life = 50;
    canJump = false;
    canShoot = true;
  }
  late double _width;
  late double _height;
  late double _x;
  late double _y;
  late bool goingToWalkRight;
  late bool goingToWalkLeft;
  late CharacterState state;
  late CharacterState stateUpdate;
  late HorizontalOrientation horizontalOrientation;
  late int life;
  late int numberOfDeadAliens;
  late WeldJoint joint;
  late bool canJump;
  late bool goingToJump;
  late bool canShoot;
  late SpriteAnimationComponent animation;
  late Map<CharacterState, List<int>> rosantStateRanges;
  double get width => _width;
  double get height => _height;

  @override
  void initializing(){
    _width = RosantUnits.width;
    _height = RosantUnits.height;
    _x = Screen.worldSize.x/2;
    _y = Screen.worldSize.y - _height - 0.04;
    goingToWalkRight = false;
    goingToWalkLeft = false;
    state = CharacterState.idleRight;
    stateUpdate = CharacterState.idleRight;
    horizontalOrientation = HorizontalOrientation.right;
    numberOfDeadAliens = 0;
    goingToJump = false;
    rosantStateRanges = {
      CharacterState.idleRight: [0, 6],
      CharacterState.idleLeft: [6, 12],
      CharacterState.walkRight: [12, 18],
      CharacterState.walkLeft: [18, 24],
    };
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..set(
      [Vector2(0, 0),
      Vector2(_width , 0),
      Vector2(_width , _height),
      Vector2(0, _height)]);
    final fixtureDef = FixtureDef(shape)
      ..density = 0.4;
    final filter = Filter();
    filter.categoryBits = CategoryBits.rosant;
    fixtureDef.filter = filter;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 10;
    animation = Animations.generateCharacterAnimations(
      sprites: Globals.rosantSprites.sublist(0, 6), 
      width: _width,
      height: _height);
    add(animation);
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(life<=0) destroyBody();
    CameraConfigurator.updateCameraMovement(camera, body);
    RosantController.updateRosantAnimation(this);
    RosantController.dontFall(this);
  }
  
}