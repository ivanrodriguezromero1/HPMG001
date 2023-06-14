import 'package:flame/components.dart';
import '/utils/globals.dart';
import '/models/aliens/alien_configuration.dart';
import '/models/aliens/alien_units.dart';

class TypeB implements AlienConfiguration{
  @override
  double width = AlienUnits.width;
  @override
  double height = 1.3 * AlienUnits.height;
  @override
  late double y;
  @override
  int life = 10;
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