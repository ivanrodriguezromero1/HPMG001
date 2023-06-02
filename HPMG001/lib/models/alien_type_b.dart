import '../models/screen.dart';
import '../models/alien_configuration.dart';

class TypeB implements AlienConfiguration{
  @override
  double width = Screen.worldSize.x/15;
  @override
  double height = 1.4 * Screen.worldSize.y/5;
  @override
  int life = 10;
}