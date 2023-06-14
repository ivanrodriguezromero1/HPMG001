import 'package:flame/components.dart';
import '/utils/globals.dart';

class Assets {
  static Assets? _instance;
  Assets._();
  static Assets get instance {
    _instance ??= Assets._();
    return _instance!;
  }
  Future<void> loadSprites() async {
    if (!Globals.assetsLoaded) {
      Globals.floorSprite = await Sprite.load('floor.png');
      Globals.backgroundSprite = await Sprite.load('background.png');
      Globals.leftArrowSprite = await Sprite.load('left_arrow.png');
      Globals.rightArrowSprite = await Sprite.load('right_arrow.png');
      Globals.upArrowSprite = await Sprite.load('up_arrow.png');
      Globals.downArrowSprite = await Sprite.load('down_arrow.png');
      Globals.buttonJumpSprite = await Sprite.load('button_jump.png');
      Globals.buttonPhysicalAttackSprite = await Sprite.load('button_physical_attack.png');
      Globals.buttonShootSprite = await Sprite.load('slingshot.png');
      Globals.buttonAxSprite = await Sprite.load('ax.png');
      Globals.buttonBowSprite = await Sprite.load('bow.png');
      Globals.buttonMacanaSprite = await Sprite.load('macana.png');
      Globals.rosantRightSprite = await Sprite.load('rosant_right.png');
      Globals.rosantLeftSprite = await Sprite.load('rosant_left.png');
      Globals.controlsSprite = await Sprite.load('controls.png');
      Globals.stoneSprite = await Sprite.load('stone.png');
      Globals.alienTypeASprite = await Sprite.load('alien_type_A.png');
      Globals.alienTypeBSprite = await Sprite.load('alien_type_B.png');
      Globals.alienTypeCSprite = await Sprite.load('alien_type_C.png');
      Globals.assetsLoaded = true;
    }
  }
}