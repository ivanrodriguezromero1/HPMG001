import 'dart:math';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/controllers/alien_controller.dart';
import '../models/alien.dart';
import '../models/direction.dart';
import '../models/rosant_bullet.dart';
import '../models/button_jump.dart';
import '../models/button_shoot.dart';
import '../models/joystick_left.dart';
import '../controllers/rosant_controller.dart';
import '../models/floor.dart';
import '../models/rosant.dart';
import '../models/background.dart';
import '../models/screen.dart';
import '../models/display_text.dart';
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
  MyGameEngineer(): super(zoom: 100, gravity: Vector2(0, 10));
 
  //--------------Main Code-------------------------------------------
  
  late List<Background> backgrounds;
  late List<Floor> floors;
  late Wall wall;
  late Rosant rosant;
  late JoystickLeft joystickLeft;
  late ButtonJump buttonJump;
  late ButtonShoot buttonShoot;
  late DisplayText displayRosantLife;
  late DisplayText displayAlienCount;
  // late DisplayText displayVelocityX;
  // late DisplayText displayVelocityY;
  late List<int> walkPointersId;
  // late Timer alienTimer;
  late int maximumAlienCount;
  // late List<Alien> aliens;

  void initialize(){
    // Max X 8.4
    backgrounds = [Background(x: 0), Background(x: totalWidth)];
    floors = [Floor(x: 0), Floor(x: totalWidth)];
    wall = Wall();
    rosant = Rosant();
    joystickLeft = JoystickLeft();
    buttonJump = ButtonJump();
    buttonShoot = ButtonShoot();
    displayRosantLife = DisplayText(x: 0.2, y: 0.3);
    displayAlienCount = DisplayText(x: Screen.worldSize.x/2, y: 0.3);
    // displayVelocityX = DisplayText(x: 0.2,y: 0.3);
    // displayVelocityY = DisplayText(x: 0.2,y: 0.6);
    walkPointersId = [];
    maximumAlienCount = 20;
    // alien = Alien();
  }
  void addToWorld(){
    addAll(backgrounds);
    addAll(floors);
    add(wall);
    add(rosant);
    add(joystickLeft);
    add(buttonJump);
    add(buttonShoot);
    add(displayRosantLife);
    add(displayAlienCount);
    // add(displayVelocityX);
    // add(displayVelocityY);
    // add(alien);
  }
  // void destroyBodies(){
  //   backgrounds[0].destroy();
  //   backgrounds[1].destroy();
  //   floors[0].destroy();
  //   floors[1].destroy();
  //   wall.destroy();
  //   rosant.destroy();
  //   joystickLeft.destroy();
  //   buttonJump.destroy();
  //   buttonShoot.destroy();
  //   displayRosantLife.destroy();
  //   // displayVelocityX.destroy();
  //   // displayVelocityY.destroy();
  //   // alien.destroy();
  // }
  void addMainComponents(){
    initialize();
    addToWorld();
  }
  // void resetWorld(){
  //   // player.play(AssetSource(loseSoundFilename));
  //   // destroyBodies();
  //   addMainComponents();
  // }
  void addAliens() {
     late Timer alienTimer;
     int numberOfAliens = 0;
     alienTimer = Timer.periodic(const Duration(seconds: 3), (timer) { 
      if(numberOfAliens < maximumAlienCount){
        add(Alien(rosant: rosant));
        numberOfAliens++;
      }else{
        alienTimer.cancel();
      }
    });
  }
  @override
  Future<void> onLoad() async {
    configCamera(camera);
    await Assets.instance.loadAssets();
    addMainComponents();
    addAliens();
  }
  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    bool goingToWalk = RosantController.checkWalkCondition(rosant, info.eventPosition.game, joystickLeft);
    if(goingToWalk) {
      walkPointersId.add(pointerId);
    }
    bool goingToJump = RosantController.checkJumpCondition(rosant, info.eventPosition.game, buttonJump);
    if(goingToJump){
      RosantController.jump(rosant);
    }
    bool goingToShoot = RosantController.checkShootCondition(info.eventPosition.game, buttonShoot);
    if(goingToShoot){
      add(RosantBullet(rosant: rosant));
    }
  }
  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);
    if (walkPointersId.contains(pointerId)){
      rosant.goingToWalkRight = false;
      rosant.goingToWalkLeft = false;
      walkPointersId.clear();
    }
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(rosant.goingToWalkRight){
      RosantController.walkRight(rosant);
    }
    if(rosant.goingToWalkLeft){
      RosantController.walkLeft(rosant);
    }

    displayRosantLife.textComponent.text = 'Rosant\'s life points: ${rosant.life}';
    displayAlienCount.textComponent.text = 'Number of Aliens: ${maximumAlienCount-rosant.numberOfDeadAliens}';
    // print((alien.body.angle*180/pi).round());
    // alien.body.linearVelocity = Vector2(-1, 0);
    
    // displayVelocityX.textComponent.text = "La velocidad en x es ${rosant.body.linearVelocity.x}";
    // displayVelocityY.textComponent.text = "La velocidad en y es ${rosant.body.linearVelocity.y}";
  }
  //--------------------------------------------------------------
}