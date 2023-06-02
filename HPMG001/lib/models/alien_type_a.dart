import '../models/screen.dart';
import '../models/alien_configuration.dart';

class TypeA implements AlienConfiguration{
  @override
  double width = Screen.worldSize.x/16;
  @override
  double height = Screen.worldSize.y/5;
  @override
  int life = 5;
}