import 'package:flame/components.dart';
import '/models/scenery/screen.dart';
import '/models/rosant/rosant.dart';
import '/models/scenery/background.dart';

class BackgroundServices {
  static void move(Background background, Rosant rosant){
    double rx = rosant.body.position.x;
    double ry = rosant.body.position.y;
    double bx = background.body.position.x;
    double by = background.body.position.y;
    // if(background.body.linearVelocity.x == 0){
      // if(rx > Screen.worldSize.x - 1.5*rosant.width && rosant.goingToWalkRight){
        // background.body.setTransform(Vector2(-background.width/4, by), 0);
        //   rosant.body.setTransform(Vector2(0.00001, ry), 0);
        // background.body.linearVelocity = Vector2(-background.width/4, 0);
        // rosant.body.linearVelocity = Vector2(-background.width/4, 0);
      // } 
      // else if(rx < Screen.worldSize.x/3 && rosant.goingToWalkLeft){
      //   // background.body.setTransform(Vector2(-0.00001, by), 0);
      // }
    // } else {
    //   if(background.body.linearVelocity.x < 0){
    //     if(bx <= -background.width/4){
    //       background.body.linearVelocity = Vector2.zero();
    //       background.body.setTransform(Vector2(-background.width/4, by), 0);
    //       rosant.body.linearVelocity = Vector2.zero();
    //       rosant.body.setTransform(Vector2(0.00001, ry), 0);
    //     }
    //   }
    // }
  }
}