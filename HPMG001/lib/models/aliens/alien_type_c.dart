import 'package:flame/components.dart';
import 'alien_units.dart';
import '/models/aliens/alien_configuration.dart';

class TypeC implements AlienConfiguration{
  @override
  double width = 2*AlienUnits.width;
  @override
  double height = AlienUnits.height/2;
  @override
  double y = AlienUnits.height/2;
  @override
  int life = 8;
  @override
  double density = 25;
  @override
  Vector2 gravity = Vector2(0, 0);
}