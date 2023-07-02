import 'package:flame/components.dart';
import '/utils/globals.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

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
      Globals.rosantSprites = await loadSpritesFromAtlas('assets/images/atlas_rosant.png',
        402, 740, 6, 4);
      Globals.controlsSprite = await Sprite.load('controls.png');
      Globals.bulletSprite = await Sprite.load('bullet.png');
      Globals.alienTypeASprite = await Sprite.load('alien_type_A.png');
      Globals.alienTypeBSprite = await Sprite.load('alien_type_B.png');
      Globals.alienTypeCSprite = await Sprite.load('alien_type_C.png');
      Globals.assetsLoaded = true;
    }
  }
  Future<List<Sprite>> loadSpritesFromAtlas(String imagePath, int frameWidth, int frameHeight,
    int columns, int rows) async {
    final ByteData imageData = await rootBundle.load(imagePath);
    final Uint8List imageBytes = Uint8List.view(imageData.buffer);
    final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    final ui.Image atlasImage = (await codec.getNextFrame()).image;
      
    List<Sprite> sprites = [];
    
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        final double left = column * frameWidth.toDouble();
        final double top = row * frameHeight.toDouble();
        final Sprite sprite = Sprite(
          atlasImage,
          srcPosition: Vector2(left, top),
          srcSize: Vector2(frameWidth.toDouble(), frameHeight.toDouble()),
        );
        sprites.add(sprite);
      }
    }
    
    return sprites;
  }
}