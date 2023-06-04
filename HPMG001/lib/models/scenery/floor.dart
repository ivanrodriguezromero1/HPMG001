import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:hpmg001/controllers/floor_controller.dart';
import 'package:hpmg001/models/rosant/rosant.dart';
import '/models/entity.dart';
import '/models/scenery/screen.dart';
import '/utils/globals.dart';

class Floor extends Entity {
  final Rosant _rosant;
  Floor({required Rosant rosant}): _rosant = rosant;
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  double get width => _width;
  @override
  void initializing(){
    _x = 0;
    _y = horizon;
    _width = 2*Screen.worldSize.x + 2;
    _height = 3*buttonUnit + 0.02;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2(-1,0), Vector2(_width, 0));
    final fixtureDef = FixtureDef(shape)
      ..density = 100
      ..friction = 0.2
      ..restitution = 0;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    final sprite = floorSprite;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0, -0.02),
      anchor: Anchor.topLeft
    ));
  }
  @override
  void update(double dt){
    super.update(dt);
    FloorController.move(this, _rosant);
  }
}