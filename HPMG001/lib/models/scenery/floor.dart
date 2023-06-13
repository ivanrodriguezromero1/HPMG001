import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:hpmg001/models/controls/controls_units.dart';
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
  // late double _height;
  late List<Contact> contacts;

  double get width => _width;
  @override
  void initializing(){
    _x = 0;
    _y = 0;
    _width = 2*Screen.worldSize.x;
    // _height = 3*buttonUnit;
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
      Vector2(0, Screen.worldSize.y - ControlsUnits.height), 
      Vector2(Screen.worldSize.x, Screen.worldSize.y - ControlsUnits.height)
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
    // final sprite = floorSprite;
    // add(SpriteComponent(
    //   sprite: sprite,
    //   size: Vector2(_width, _height),
    //   position: Vector2(0, -0.02),
    //   anchor: Anchor.topLeft
    // ));
  }
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    contacts.add(contact);
    if(other is Rosant){
      other.canJump = true;
    }
  }
  @override
  void endContact(Object other, Contact contact) {
    super.endContact(other, contact);
    contacts.remove(contact);
    if(other is Rosant){
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