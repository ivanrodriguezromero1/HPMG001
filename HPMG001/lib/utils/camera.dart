import 'package:flame/game.dart';
import '/models/scenery/screen.dart';

void configCamera(Camera camera){
    double width = 836; 
    double height = 393;  
    Screen.setScreenSize(Vector2(width, height));
    camera.viewport = FixedResolutionViewport(Screen.screenSize);
  }