import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import '/models/controls/controls_units.dart';
import '/models/scenery/screen.dart';

class Globals {
  static late Sprite floorSprite;
  static late Sprite backgroundSprite;
  static late Sprite leftArrowSprite;
  static late Sprite rightArrowSprite;
  static late Sprite upArrowSprite;
  static late Sprite downArrowSprite;
  static late Sprite buttonJumpSprite;
  static late Sprite buttonPhysicalAttackSprite;
  static late Sprite buttonShootSprite;
  static late Sprite buttonAxSprite;
  static late Sprite buttonBowSprite;
  static late Sprite buttonMacanaSprite;
  static late Sprite rosantRightSprite;
  static late Sprite rosantLeftSprite;
  static late List<Sprite> rosantSprites;
  static late Sprite controlsSprite;
  static late Sprite bulletSprite;
  static late Sprite alienTypeASprite;
  static late Sprite alienTypeBSprite;
  static late Sprite alienTypeCSprite;
  static AudioPlayer player = AudioPlayer();
  static bool assetsLoaded = false;
  static Vector2 initialWorldLinearVelocity = Vector2(-4, 0);
  static double initialBladeAngularVelocity = radians(360);
  static Vector2 worldLinearVelocity = initialWorldLinearVelocity;
  static double bladeAngularVelocity = initialBladeAngularVelocity;
  static double horizon = Screen.worldSize.y - ControlsUnits.height;
  static Vector2 gravity = Vector2(0, 98.1);
}