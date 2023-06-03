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
      // floorSprite = await Sprite.load(floorFilename);
      backgroundSprite = await Sprite.load(backgroundFilename);
      arrowSprite = await Sprite.load(arrowFilename);
      
      assetsLoaded = true;
    }
}
}