import 'package:flame/components.dart';
import '/utils/globals.dart';
import '/models/aliens/alien_configuration.dart';
import '/models/aliens/alien_units.dart';

class TypeC implements AlienConfiguration{
  @override
  double width = 2*AlienUnits.width;
  @override
  double height = AlienUnits.height/2;
  @override
  double y = AlienUnits.height/2;
  @override
  int life = 40;
  @override
  double density = 50;
  @override
  Vector2 gravity = Vector2(0, 0);
  @override
  Sprite sprite  = Globals.alienTypeCSprite;
}