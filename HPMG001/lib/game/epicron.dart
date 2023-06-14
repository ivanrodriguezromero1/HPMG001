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
  Epicron(): super(zoom: 100, gravity: Globals.gravity);  
  late Background background;
  late Floor floor;
  late WallLeft wallLeft;
  late WallRight wallRight;
  late Rosant rosant;
  late ButtonLeft buttonLeft;
  late ButtonRight buttonRight;
  late ButtonJump buttonJump;
  late ButtonPhysicalAttack buttonPhysicalAttack;
  late ButtonShoot buttonShoot;
  late ButtonAx buttonAx;
  late ButtonBow buttonBow;
  late ButtonMacana buttonMacana;
  late DisplayText displayRosantLife;
  late DisplayText displayAlienCount;
  late List<int> walkPointersId;
  late List<int> jumpPointersId;
  late AlienAddWorld alienAddWorld;

  void initialize() {
    rosant = Rosant();
    background = Background(rosant: rosant);
    floor = Floor(rosant: rosant);
    wallLeft = WallLeft();
    wallRight = WallRight();
    buttonLeft = ButtonLeft();
    buttonRight = ButtonRight();
    buttonJump = ButtonJump();
    buttonPhysicalAttack = ButtonPhysicalAttack();
    buttonShoot = ButtonShoot();
    buttonAx = ButtonAx();
    buttonBow = ButtonBow();
    buttonMacana = ButtonMacana();
    displayRosantLife = DisplayText(x: 0.2, y: 0.3);
    displayAlienCount = DisplayText(x: Screen.worldSize.x/2, y: 0.3);
    walkPointersId = [];
    jumpPointersId = [];
    alienAddWorld = AlienAddWorld(rosant: rosant);
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
    add(buttonPhysicalAttack);
    add(buttonShoot);
    add(buttonAx);
    add(buttonBow);
    add(buttonMacana);
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
    bool goingToWalk = RosantController.checkWalkCondition(rosant, info.eventPosition.game, buttonRight, buttonLeft);
    if(goingToWalk) {
      walkPointersId.add(pointerId);
    }
    bool goingToJump = RosantController.checkJumpCondition(rosant, info.eventPosition.game, buttonJump);
    if(goingToJump) {
      jumpPointersId.add(pointerId);
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
    displayAlienCount.textComponent.text = 'Número de Aliens restantes: ${alienAddWorld.maximumAlienCount-rosant.numberOfDeadAliens}';

  }
}