import 'package:flame/components.dart';
import 'alien_units.dart';
import '/utils/globals.dart';
import '/models/scenery/screen.dart';
import '/models/aliens/alien_configuration.dart';

class TypeA implements AlienConfiguration{
  @override
  double width = AlienUnits.width;
  @override
  double height = AlienUnits.height;
  @override
  late double y;
  @override
  int life = 5;
  @override
  double density = 25;
  @override
  Vector2 gravity = Vector2(0, 9.81);
  TypeA(){
    y = horizon - height;
  }
}