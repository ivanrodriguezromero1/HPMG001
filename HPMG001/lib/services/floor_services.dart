
import 'package:flame/components.dart';
import '/models/rosant/rosant.dart';
import '/models/scenery/floor.dart';

class FloorServices {
  static void move(Floor floor, Rosant rosant){
    double x = floor.body.position.x;
    double y = floor.body.position.y;
    if(x > -floor.width/2 && rosant.goingToWalkRight){
        floor.body.setTransform(Vector2(x - 0.02, y), 0);
      } else if(x < 0 && rosant.goingToWalkLeft){
        floor.body.setTransform(Vector2(x + 0.02, y), 0);
      }
    }
}