import 'package:flame/components.dart';
import 'package:juego_ingeniero/models/rosant.dart';
import '../utils/globals.dart';

class RosantController {
  static bool _canJump = true;
  static void setCanJump(Rosant rosant){
    double positionY = rosant.body.position.y;
    double positionYOnFloor = horizon - rosant.height/2;
    _canJump = positionY >= positionYOnFloor - 0.5;
  }
  static void jump(Rosant rosant){
    if(_canJump){
      // rosant.body.linearVelocity = Vector2(rosant.body.linearVelocity.x, -7);
      final force = Vector2(0, -20);
      rosant.body.applyLinearImpulse(force);
    }
  }
  static void walkLeft(Rosant rosant){
    // rosant.body.linearDamping = 0;
    // final force = Vector2(-0.45, 0);
    // rosant.body.applyLinearImpulse(force);
    rosant.body.linearVelocity = Vector2(-2, rosant.body.linearVelocity.y);
  }
  static void walkRight(Rosant rosant){
    // rosant.body.linearDamping = 0;
    // final force = Vector2(0.45, 0);
    // rosant.body.applyLinearImpulse(force);
    rosant.body.linearVelocity = Vector2(2, rosant.body.linearVelocity.y);
  }
  static void standUp(Rosant rosant){
    if(_canJump){
      bool condition = rosant.body.angle.abs().round()!=0 && rosant.body.angle.abs()<=radians(360);
      if(condition){
        rosant.body.angularVelocity = radians(360);
      } else if(!condition){
        rosant.body.angularVelocity = 0;
        rosant.body.setTransform(rosant.body.position, 0);
      }
    }
  }
  static bool hasLost(Rosant rosant){
    return rosant.body.position.x <= -1*(rosant.width/2);
  }

}
