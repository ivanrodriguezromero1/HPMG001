import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/controls/controls_units.dart';
import '/utils/xml.dart';
import '/models/rosant/rosant.dart';
import '/models/entity.dart';
import '/models/scenery/screen.dart';
import '/utils/globals.dart';

class Floor extends Entity with ContactCallbacks {
  final Rosant _rosant;
  Floor({required Rosant rosant}): _rosant = rosant;
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  late List<Contact> contacts;

  double get width => _width;
  @override
  void initializing(){
    _x = 0;
    _y = 0;
    _width = 2*Screen.worldSize.x;
    _height = Screen.worldSize.y - ControlsUnits.height;
    contacts = [];
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );
    final shape = EdgeShape()..set(
      Vector2(0, _height), 
      Vector2(_width, _height)
      );
    final fixtureDef = FixtureDef(shape)
      ..density = 1000
      ..friction =  0.5;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 15;
    // final polygons  = await Xml.createBodiesFromXml();
    // for (final polygonVertices in polygons) {
    //   final shape = PolygonShape()..set(polygonVertices);
    //   final fixtureDef = FixtureDef(shape)
    //     ..density = 100
    //     ..friction = 0.5;
    //     // ..restitution = 0;
    //   body.createFixture(fixtureDef);
    // }
    final spriteControls = Globals.controlsSprite;
    add(SpriteComponent(
      sprite: spriteControls,
      size: Vector2(Screen.worldSize.x, ControlsUnits.height),
      position: Vector2(0, Globals.horizon),
      anchor: Anchor.topLeft
    ));
  }
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if(other is Rosant){
      contacts.add(contact);
      other.canJump = true;
    }
  }
  @override
  void endContact(Object other, Contact contact) {
    super.endContact(other, contact);
    if(other is Rosant){
      contacts.remove(contact);
      if(contacts.isEmpty){
        other.canJump = false;
      }
    }
  }
  @override
  void update(double dt){
    super.update(dt);
    // FloorController.move(this, _rosant);
  }
}