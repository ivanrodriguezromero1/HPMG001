import 'package:flame/components.dart';
import '/models/rosant/rosant.dart';
import '/models/scenery/background.dart';
import '/models/scenery/screen.dart';

class BackgroundService {
  static void move(Background background,Rosant rosant){
    if(background.body.position.x > -background.width/2 && rosant.goingToWalkRight){
        background.body.setTransform(Vector2(background.body.position.x - 0.02, 0), 0);
      } else if(background.body.position.x < 0 && rosant.goingToWalkLeft){
        background.body.setTransform(Vector2(background.body.position.x + 0.02, 0), 0);
      }
    }
}