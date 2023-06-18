import 'package:flame/game.dart';
import '/models/scenery/screen.dart';

void configCamera(Camera camera){
  double width = 1100; //836
  double height = 410;  
  Screen.setScreenSize(Vector2(width, height));
  camera.viewport = FixedResolutionViewport(Screen.screenSize);
}