import 'package:flame/game.dart';
import '../models/scenery/screen.dart';

void configCamera(Camera camera){
    double width = 836; //3652 - 49.83
    double height = 393; //288 - 3.93
    Screen.setScreenSize(Vector2(width, height));
    camera.viewport = FixedResolutionViewport(Screen.screenSize);
  }