import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/models/button_jump.dart';
import '../models/joystick_left.dart';
import '../models/joystick_right.dart';
import '../controllers/rosant_controller.dart';
import '../models/floor.dart';
import '../models/rosant.dart';
import '../controllers/background_controller.dart';
import '../models/background.dart';
import '../models/screen.dart';
import '../models/counter.dart';
import '../models/wall.dart';
import '../utils/camera.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';
import '../utils/load.dart';


class GameEngineer extends StatefulWidget {
  const GameEngineer({Key? key}) : super(key: key);
  @override
  GameEngineerState createState() => GameEngineerState();
}
Game controlledGameBuilder() {
  return MyGameEngineer();
}
class GameEngineerState extends State<GameEngineer> {
  Widget buildGameWidget(BuildContext context) => const GameWidget.controlled(
    gameFactory: controlledGameBuilder
  );
  @override
  Widget build(BuildContext context) {
    return buildGameWidget(context);
  }
}
class MyGameEngineer extends Forge2DGame with MultiTouchTapDetector  {
  MyGameEngineer(): super(zoom: 100, gravity: Vector2(0, 15));
 
  //--------------Main Code-------------------------------------------
  
  late List<Background> backgrounds;
  late List<Floor> floors;
  late Wall wall;
  late Rosant rosant;
  late JoystickRight joystickRight;
  late JoystickLeft joystickLeft;
  late ButtonJump buttonJump;
  bool goingToWalkRight = false;
  bool goingToWalkLeft = false;
  List<int> walkPointersId = [];
  late Counter counter;

  void initialize(){
    // Max X 8.4
    backgrounds = [Background(x: 0), Background(x: totalWidth)];
    floors = [Floor(x: 0), Floor(x: totalWidth)];
    wall = Wall();
    rosant = Rosant();
    joystickRight = JoystickRight();
    joystickLeft = JoystickLeft();
    buttonJump = ButtonJump();
    counter = Counter();
  }
  void addToWorld(){
    addAll(backgrounds);
    addAll(floors);
    add(wall);
    add(rosant);
    add(joystickRight);
    add(joystickLeft);
    add(buttonJump);
    add(counter);
    
  }
  void destroyBodies(){
    backgrounds[0].destroy();
    backgrounds[1].destroy();
    floors[0].destroy();
    floors[1].destroy();
    wall.destroy();
    rosant.destroy();
    joystickRight.destroy();
    joystickLeft.destroy();
    buttonJump.destroy();
    counter.destroy(); 
  }
  void addComponents(){
    initialize();
    addToWorld();
  }
  void resetWorld(){
    // player.play(AssetSource(loseSoundFilename));
    destroyBodies();
    addComponents();
  }
  @override
  Future<void> onLoad() async {
    configCamera(camera);
    await Assets.instance.loadAssets();
    addComponents();
  }

  bool checkWalkCondition(Vector2 p) {
    final jx = joystickLeft.body.position.x;
    final jy = joystickLeft.body.position.y;
    if(p.x >= jx + joystickLeft.width/2 && p.x <= jx + joystickLeft.width  
      && p.y >= jy && p.y <= jy + joystickLeft.height) {
      goingToWalkRight = true;
      goingToWalkLeft = false;
      return true;
    } else if (p.x >= jx && p.x < jx + joystickLeft.width/2 
      && p.y >= jy && p.y <= jy + joystickLeft.height) {
      goingToWalkLeft = true;
      goingToWalkRight = false;
      return true;
    } else {
      return false;
    }
  }
  void checkJumpCondition(Vector2 p) {
    final bx = buttonJump.body.position.x;
    final by = buttonJump.body.position.y;
    final ry = rosant.body.position.y;
    final rh = rosant.height;
    final rvy = rosant.body.linearVelocity.y;
    if(p.x >= bx && p.x <= bx + buttonJump.width  
      && p.y >= by && p.y <= by + buttonJump.height
      && rvy.round() == 0 && (horizon - rh/2 - ry).round() == 0
      ) {
        RosantController.jump(rosant);
    }
  }
  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    bool goingToWalk = checkWalkCondition(info.eventPosition.game);
    if(goingToWalk) {
      walkPointersId.add(pointerId);
    }
    checkJumpCondition(info.eventPosition.game);
  }
  @override
  void onLongTapDown(int pointerId, TapDownInfo info) {
    super.onLongTapDown(pointerId, info);
    checkWalkCondition(info.eventPosition.game);
  }
  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);
    if (walkPointersId.contains(pointerId)){
      goingToWalkRight = false;
      goingToWalkLeft = false;
      walkPointersId.clear();
    }
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(goingToWalkRight){
      RosantController.walkRight(rosant);
    }
    if(goingToWalkLeft){
      RosantController.walkLeft(rosant);
    }
    counter.count.text = rosant.body.linearVelocity.x.toString();
    // BackgroundController.move(backdrops, 0);
    // BackgroundController.move(floors, posY0);
    // EngineerController.setCanJump(engineer);
    // EngineerController.standUp(engineer);
    // if(EngineerController.hasLost(engineer)){
    //   resetWorld();
    // }
    
  }
  //--------------------------------------------------------------
}