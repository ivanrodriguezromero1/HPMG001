import 'package:flame/components.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';

class Assets {
  static Assets? _instance;
  Assets._();
  static Assets get instance {
    _instance ??= Assets._();
    return _instance!;
  }
  Future<void> loadAssets() async {
    if (!assetsLoaded) {
      floorSprite = await Sprite.load(floorFilename);
      backgroundSprite = await Sprite.load(backgroundFilename);
      leftArrowSprite = await Sprite.load(leftArrowFilename);
      rightArrowSprite = await Sprite.load(rightArrowFilename);
      upArrowSprite = await Sprite.load(upArrowFilename);
      downArrowSprite = await Sprite.load(downArrowFilename);
      assetsLoaded = true;
    }
}
}