import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/controls/button.dart';
import '/utils/globals.dart';

class ButtonLeft extends Button {
  @override
  void initializing() {
    super.initializing();
    position = Vector2(0, 
      Globals.horizon);
    sprite = Globals.leftArrowSprite;
  }
}