import 'dart:math';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
import 'package:flutter/material.dart';
import 'package:hpmg001/models/controls/button_down.dart';
import 'package:hpmg001/models/controls/button_up.dart';
import '/models/aliens/alien_bullet.dart';
import '/models/controls/button_right.dart';
import '/controllers/alien_controller.dart';
import '/models/aliens/alien.dart';
import '../models/rosant/rosant_direction.dart';
import '../models/rosant/rosant_bullet.dart';
import '/models/controls/button_jump.dart';
import '/models/controls/button_shoot.dart';
import '/models/controls/button_left.dart';
import '/controllers/rosant_controller.dart';
import '/models/scenery/floor.dart';
import '/models/rosant/rosant.dart';
import '/models/scenery/background.dart';
import '/models/scenery/screen.dart';
import '/models/scenery/display_text.dart';
import '/models/scenery/wall.dart';
import '/utils/camera.dart';
import '/utils/constants.dart';
import '/utils/globals.dart';
import '/utils/load.dart';


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
  MyGameEngineer(): super(zoom: 100, gravity: Vector2(0, 9.81));
 
  //--------------Main Code-------------------------------------------
  
  late Background background;
  late Floor floor;
  late Wall wall;
  late Rosant rosant;
  late ButtonLeft buttonLeft;
  late ButtonRight buttonRight;
  late ButtonUp buttonUp;
  late ButtonDown buttonDown;
  late ButtonJump buttonJump;
  late ButtonShoot buttonShoot;
  late DisplayText displayRosantLife;
  late DisplayText displayAlienCount;
  // late DisplayText displayVelocityX;
  // late DisplayText displayVelocityY;
  late List<int> walkPointersId;
  // late Timer alienTimer;
  late int alienCount;
  late int maximumAlienCount;
  // late List<Alien> aliens;

  void initialize(){
    // Max X 8.36
    rosant = Rosant();
    background = Background(rosant: rosant);
    floor = Floor(rosant: rosant);
    wall = Wall();
    buttonLeft = ButtonLeft();
    buttonRight = ButtonRight();
    buttonUp = ButtonUp();
    buttonDown = ButtonDown();
    buttonJump = ButtonJump();
    buttonShoot = ButtonShoot();
    displayRosantLife = DisplayText(x: 0.2, y: 0.3);
    displayAlienCount = DisplayText(x: Screen.worldSize.x/2, y: 0.3);
    // displayVelocityX = DisplayText(x: 0.2,y: 0.3);
    // displayVelocityY = DisplayText(x: 0.2,y: 0.6);
    walkPointersId = [];
    alienCount = 0;
    maximumAlienCount = 0;
    // alien = Alien();
  }
  void addToWorld(){
    add(background);
    add(floor);
    add(wall);
    add(rosant);
    add(buttonLeft);
    add(buttonRight);
    add(buttonUp);
    add(buttonDown);
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
    int interval = Random().nextInt(3) + 1;
    Future.delayed(Duration(seconds: interval), (){
      if(alienCount < maximumAlienCount){
          Alien alien = Alien(rosant: rosant);
          add(alien);
          addAlienBullet(alien);
          alienCount++;
          addAliens();
        } else {
        alienCount = 0;
      }
    });
  }
  void addAlienBullet(Alien alien) {
    int interval = Random().nextInt(1) + 1;    
    Future.delayed(Duration(seconds: interval), (){
    if(alien.life > 0){
        add(AlienBullet(alien: alien));
        addAlienBullet(alien);
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
    bool goingToWalk = RosantController.checkWalkCondition(rosant, info.eventPosition.game, buttonRight, buttonLeft);
    if(goingToWalk) {
      walkPointersId.add(pointerId);
    }
    bool goingToJump = RosantController.checkJumpCondition(rosant, info.eventPosition.game, buttonJump);
    if(goingToJump){
      RosantController.jump(rosant);
    }
    bool goingToShoot = RosantController.checkShootCondition(rosant, info.eventPosition.game, buttonShoot);
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
    RosantController.walkRight(rosant);
    RosantController.walkLeft(rosant);
    displayRosantLife.textComponent.text = 'Rosant\'s life points: ${rosant.life}';
    displayAlienCount.textComponent.text = 'Number of remaining Aliens : ${maximumAlienCount-rosant.numberOfDeadAliens}';
  }
  //--------------------------------------------------------------
}