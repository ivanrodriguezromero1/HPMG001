import '/models/scenery/screen.dart';
import '/models/aliens/alien_configuration.dart';

class TypeB implements AlienConfiguration{
  @override
  double width = Screen.worldSize.x/10;
  @override
  double height = 1.3 * Screen.worldSize.y/4;
  @override
  int life = 10;
  @override
  double density = 100;
}