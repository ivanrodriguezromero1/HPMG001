import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/controls/button.dart';
import '/models/controls/controls_units.dart';
import '/utils/globals.dart';

class ButtonRight extends Button {
  @override
  void initializing() {
    super.initializing();
    position = Vector2(ControlsUnits.width, 
      Globals.horizon);
    sprite = Globals.rightArrowSprite;
  }
}