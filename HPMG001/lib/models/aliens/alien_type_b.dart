import 'package:flame/components.dart';
import '/utils/globals.dart';
import '/models/aliens/alien_configuration.dart';
import '/models/aliens/alien_units.dart';

class TypeB implements AlienConfiguration{
  @override
  double width = 2*AlienUnits.width;
  @override
  double height = 1.8 * AlienUnits.height;
  @override
  late double y;
  @override
  int life = 50;
  @override
  double density = 100;
  @override
  Vector2 gravity = Globals.gravity;
  @override
  Sprite sprite  = Globals.alienTypeBSprite;
  TypeB(){
    y = Globals.horizon - height;
  }
}