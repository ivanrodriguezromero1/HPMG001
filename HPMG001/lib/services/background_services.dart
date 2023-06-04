import 'package:flame/components.dart';
import '/models/rosant/rosant.dart';
import '/models/scenery/background.dart';

class BackgroundServices {
  static void move(Background background, Rosant rosant){
    double x = background.body.position.x;
    double y = background.body.position.y;
    if(x > -background.width/2 && rosant.goingToWalkRight){
        background.body.setTransform(Vector2(x - 0.02, y), 0);
      } else if(x < 0 && rosant.goingToWalkLeft){
        background.body.setTransform(Vector2(x + 0.02, y), 0);
      }
    }
}