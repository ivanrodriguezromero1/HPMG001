import 'package:flame/components.dart';

class Screen {
  static late Vector2 _screenSize;
  static late Vector2 _worldSize;
  
  static Vector2 get screenSize => _screenSize;
  static Vector2 get worldSize => _worldSize;

  static void setScreenSize(Vector2 size) {
    _screenSize = size;
    _worldSize = size/100;
  }
}