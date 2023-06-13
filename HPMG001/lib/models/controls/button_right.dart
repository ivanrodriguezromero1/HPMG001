import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/controls/button.dart';
import '/models/controls/controls_units.dart';
import '/models/scenery/screen.dart';
import '/utils/globals.dart';

class ButtonRight extends Button {
  @override
  void initializing() {
    super.initializing();
    position = Vector2(ControlsUnits.width, Screen.worldSize.y - ControlsUnits.height);
    sprite = rightArrowSprite;
  }
}