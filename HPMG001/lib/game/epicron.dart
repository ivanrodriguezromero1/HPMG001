import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/controls/button_ax.dart';
import '/models/controls/button_bow.dart';
import '/models/controls/button_macana.dart';
import '/models/controls/button_physical_attack.dart';
import '/models/aliens/alien_add_world.dart';
import '/models/scenery/wall_right.dart';
import '/utils/globals.dart';
import '/models/controls/button_right.dart';
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

class Epicron extends Forge2DGame with MultiTouchTapDetector, HasTappables  {
  final Rosant _rosant;
  Epicron({required Rosant rosant})
    : _rosant = rosant, super(zoom: 100, gravity: Globals.gravity);  
  late Background background;
  late Floor floor;
  late WallLeft wallLeft;
  late WallRight wallRight;
  // late ButtonLeft buttonLeft;
  // late ButtonRight buttonRight;
  // late ButtonJump buttonJump;
  // late ButtonPhysicalAttack buttonPhysicalAttack;
  // late ButtonShoot buttonShoot;
  // late ButtonAx buttonAx;
  // late ButtonBow buttonBow;
  // late ButtonMacana buttonMacana;
  late DisplayText displayRosantLife;
  late DisplayText displayAlienCount;
  late List<int> walkPointersId;
  late List<int> jumpPointersId;
  late AlienAddWorld alienAddWorld;

  void initialize() {
    background = Background(rosant: _rosant);
    floor = Floor(rosant: _rosant);
    wallLeft = WallLeft();
    wallRight = WallRight();
    // buttonLeft = ButtonLeft();
    // buttonRight = ButtonRight();
    // buttonJump = ButtonJump();
    // buttonPhysicalAttack = ButtonPhysicalAttack();
    // buttonShoot = ButtonShoot();
    // buttonAx = ButtonAx();
    // buttonBow = ButtonBow();
    // buttonMacana = ButtonMacana();
    displayRosantLife = DisplayText(x: 0.2, y: 0.3);
    displayAlienCount = DisplayText(x: Screen.worldSize.x/2, y: 0.3);
    walkPointersId = [];
    jumpPointersId = [];
    alienAddWorld = AlienAddWorld(rosant: _rosant);
  }
  void addToWorld() {
    add(background);
    add(floor);
    add(wallLeft);
    add(wallRight);
    add(_rosant);
    // add(buttonLeft);
    // add(buttonRight);
    // add(buttonJump);
    // add(buttonPhysicalAttack);
    // add(buttonShoot);
    // add(buttonAx);
    // add(buttonBow);
    // add(buttonMacana);
    add(displayRosantLife);
    add(displayAlienCount);
  }
  void addMainComponents() {
    initialize();
    addToWorld();
  }
  @override
  Future<void> onLoad() async {
    configCamera(camera);
    await Assets.instance.loadSprites();
    addMainComponents();
    alienAddWorld.addAliens(add);
  }
  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    // bool goingToWalk = RosantController.checkWalkCondition(_rosant, info.eventPosition.game, buttonRight, buttonLeft);
    // if(goingToWalk) {
    //   walkPointersId.add(pointerId);
    // }
    // bool goingToJump = RosantController.checkJumpCondition(_rosant, info.eventPosition.game, buttonJump);
    // if(goingToJump) {
    //   jumpPointersId.add(pointerId);
    // }
    // bool goingToShoot = RosantController.checkShootCondition(_rosant, info.eventPosition.game, buttonShoot);
    // if(goingToShoot) {
    //   add(RosantBullet(rosant: _rosant));
    // }
  }
  void cancelMove(int pointerId){
    if (walkPointersId.contains(pointerId)){
      _rosant.goingToWalkRight = false;
      _rosant.goingToWalkLeft = false;
      // buttonLeft.updateSprite(1);
      // buttonRight.updateSprite(1);
      walkPointersId.clear();
    }
    if (jumpPointersId.contains(pointerId)){
      _rosant.goingToJump = false;
      // buttonJump.updateSprite(1);
      jumpPointersId.clear();
    }
    // buttonShoot.updateSprite(1);
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
    RosantController.walkRight(_rosant);
    RosantController.walkLeft(_rosant);
    RosantController.jump(_rosant);
    displayRosantLife.textComponent.text = 'Puntos de vida de Rosant: ${_rosant.life}';
    displayAlienCount.textComponent.text = 'Número de Aliens restantes: ${alienAddWorld.maximumAlienCount-_rosant.numberOfDeadAliens}';
    // camera.followBodyComponent(_rosant);
    // if(_rosant.canJump){
    //   _rosant.body.linearVelocity = Vector2(-40, -40);
    // }
  }
}