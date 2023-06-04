import '/models/scenery/screen.dart';
import '/models/aliens/alien_configuration.dart';

class TypeA implements AlienConfiguration{
  @override
  double width = Screen.worldSize.x/10;
  @override
  double height = Screen.worldSize.y/4;
  @override
  int life = 5;
  @override
  double density = 25;
}