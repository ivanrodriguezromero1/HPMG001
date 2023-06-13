import 'dart:math';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '/models/controls/button.dart';
import '/models/controls/button_down.dart';
import '/models/controls/button_up.dart';
import '/models/controls/controls_units.dart';
import '/models/rosant/rosant_image.dart';
import '/models/scenery/wall_right.dart';
import '/utils/globals.dart';
import '/models/aliens/alien_bullet.dart';
import '/models/controls/button_right.dart';
import '/models/aliens/alien.dart';
import '/models/rosant/rosant_bullet.dart';
import '/models/controls/button_jump.dart';
import '/models/controls/button_shoot.dart';
import '/models/controls/button_left.dart';
import '/controllers/rosant_controller.dart';
import '/models/scenery/floor.dart';
import '/models/rosant/rosant.dart';
import '/models/scenery/background.dart';
import '/models/scenery/screen.dart';
import '/models/scenery/display_text.dart';
import '/models/scenery/wall_left.dart';
import '/utils/camera.dart';
import '/utils/assets.dart';

class GameEpicron extends StatefulWidget {
  const GameEpicron({Key? key}) : super(key: key);
  @override
  GameEpicronState createState() => GameEpicronState();
}
Game controlledGameBuilder() {
  return MyGameEpicron();
}
class GameEpicronState extends State<GameEpicron> {
  Widget buildGameWidget(BuildContext context) => const GameWidget.controlled(
    gameFactory: controlledGameBuilder
  );
  @override
  Widget build(BuildContext context) {
    return buildGameWidget(context);
  }
}
class MyGameEpicron extends Forge2DGame with MultiTouchTapDetector, HasTappables  {
  MyGameEpicron(): super(zoom: 100, gravity: Vector2(0, 98.1));
 
  //--------------Main Code-------------------------------------------
  
  late Background background;
  late Floor floor;
  late WallLeft wallLeft;
  late WallRight wallRight;
  late Rosant rosant;
  late ButtonLeft buttonLeft;
  late ButtonRight buttonRight;
  late ButtonJump buttonJump;
  late ButtonShoot buttonShoot;
  late DisplayText displayRosantLife;
  late DisplayText displayAlienCount;
  late List<int> walkPointersId;
  late List<int> jumpPointersId;
  late int alienCount;
  late int maximumAlienCount;

  void initialize() {
    rosant = Rosant();
    background = Background(rosant: rosant);
    floor = Floor(rosant: rosant);
    wallLeft = WallLeft();
    wallRight = WallRight();
    buttonLeft = ButtonLeft();
    buttonRight = ButtonRight();
    buttonJump = ButtonJump();
    buttonShoot = ButtonShoot();
    displayRosantLife = DisplayText(x: 0.2, y: 0.3);
    displayAlienCount = DisplayText(x: Screen.worldSize.x/2, y: 0.3);
    walkPointersId = [];
    jumpPointersId = [];
    alienCount = 0;
    maximumAlienCount = 0;
  }
  void addToWorld() {
    add(background);
    add(floor);
    add(wallLeft);
    add(wallRight);
    add(rosant);
    add(buttonLeft);
    add(buttonRight);
    add(buttonJump);
    add(buttonShoot);
    add(displayRosantLife);
    add(displayAlienCount);
  }
  void addMainComponents() {
    initialize();
    addToWorld();
  }
  void addAliens() {
    int interval = Random().nextInt(3) + 1;
    Future.delayed(Duration(seconds: interval), (){
      if(alienCount < maximumAlienCount && rosant.life > 0){
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
    if(alien.life > 0 && rosant.life > 0){
        add(AlienBullet(alien: alien));
        addAlienBullet(alien);
      }
    });
  }
  @override
  Future<void> onLoad() async {
    configCamera(camera);
    await Assets.instance.loadSprites();
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
    // bool goingToLookUpward = RosantController.checkLookUpwardCondition(rosant, info.eventPosition.game, buttonUp);
    // if(goingToLookUpward) {
    //     //animación de mirar hacia arriba
    // }
    bool goingToJump = RosantController.checkJumpCondition(rosant, info.eventPosition.game, buttonJump);
    if(goingToJump) {
      jumpPointersId.add(pointerId);
      // RosantController.jump(rosant);
      // rosant.canJump =  true;
    }
    bool goingToShoot = RosantController.checkShootCondition(rosant, info.eventPosition.game, buttonShoot);
    if(goingToShoot) {
      add(RosantBullet(rosant: rosant));
    }
  }
  void cancelMove(int pointerId){
    if (walkPointersId.contains(pointerId)){
      rosant.goingToWalkRight = false;
      rosant.goingToWalkLeft = false;
      buttonLeft.updateSprite(1);
      buttonRight.updateSprite(1);
      walkPointersId.clear();
    }
    if (jumpPointersId.contains(pointerId)){
      rosant.goingToJump = false;
      buttonJump.updateSprite(1);
      jumpPointersId.clear();
    }
    buttonShoot.updateSprite(1);
  }
  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);
    cancelMove(pointerId);
  }
  @override
  void onTapCancel(int pointerId) {
    super.onTapCancel(pointerId);
    cancelMove(pointerId);
  }
  @override
  void update(double dt) {
    super.update(dt);
    RosantController.walkRight(rosant);
    RosantController.walkLeft(rosant);
    RosantController.jump(rosant);
    displayRosantLife.textComponent.text = 'Puntos de vida de Rosant: ${rosant.life}';
    displayAlienCount.textComponent.text = 'Número de Aliens restantes: ${maximumAlienCount-rosant.numberOfDeadAliens}';
  }
  //--------------------------------------------------------------
}