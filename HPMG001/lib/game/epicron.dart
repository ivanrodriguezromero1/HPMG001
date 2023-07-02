import 'dart:async';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/aliens/alien_add_world.dart';
import '/models/scenery/wall_right.dart';
import '/utils/globals.dart';
import '/models/scenery/floor.dart';
import '/models/rosant/rosant.dart';
import '/models/scenery/background.dart';
import '/models/scenery/screen.dart';
import '/models/scenery/display_text.dart';
import '/models/scenery/wall_left.dart';
import '/utils/camera.dart';
import '/utils/assets.dart';

class Epicron extends Forge2DGame {
  final Rosant _rosant;
  Epicron({required Rosant rosant})
    : _rosant = rosant, super(zoom: 100, gravity: Globals.gravity);  
  late Background background;
  late Floor floor;
  late WallLeft wallLeft;
  late WallRight wallRight;
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
    add(displayRosantLife);
    add(displayAlienCount);
  }
  void addMainComponents() {
    initialize();
    addToWorld();
  }
  @override
  Future<void> onLoad() async {
    CameraConfigurator.configCamera(camera);
    await Assets.instance.loadSprites();
    addMainComponents();
    alienAddWorld.addAliens();
  }
  @override
  void update(double dt) {
    super.update(dt);
    displayRosantLife.textComponent.text = 'Puntos de vida de Rosant: ${_rosant.life}';
    displayAlienCount.textComponent.text = 'Número de Aliens restantes: ${alienAddWorld.maximumAlienCount-_rosant.numberOfDeadAliens}';
  }
}