import 'package:flame/components.dart';

class Screen {
  static Vector2 _cameraSize = Vector2.zero();
  static Vector2 _worldSize = Vector2.zero();
  static Vector2 _screenSize = Vector2.zero();
  static Vector2 get cameraSize => _cameraSize;
  static Vector2 get worldSize => _worldSize;
  static Vector2 get screenSize => _screenSize;
  static void setScreenSize(Vector2 size) {
    _cameraSize = size*10;
    _worldSize = size/10;
    _screenSize = size;
  }
}