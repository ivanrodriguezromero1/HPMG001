import 'package:flame/components.dart';
import '/models/controls/button_right.dart';
import '/models/controls/button_shoot.dart';
import '/models/rosant/rosant_direction.dart';
import '/models/controls/button_jump.dart';
import '/models/controls/button_left.dart';
import '/models/rosant/rosant.dart';

class RosantServices {
  static void jump(Rosant rosant){
    if(rosant.goingToJump && rosant.canJump){
      final force = Vector2(0, -400);
      rosant.body.applyLinearImpulse(force);
    }
  }
  static void walkLeft(Rosant rosant){
    if(rosant.goingToWalkLeft){
      final force = Vector2(-15, 0);
      rosant.body.applyLinearImpulse(force);
    }
  }
  static void walkRight(Rosant rosant){
    if(rosant.goingToWalkRight){
      final force = Vector2(15, 0);
      rosant.body.applyLinearImpulse(force);
    }
  }
  static bool checkWalkCondition(Rosant rosant, Vector2 touch, ButtonRight buttonRight, ButtonLeft buttonLeft) {
    if(rosant.life <= 0) return false;
    double bLeftx = buttonLeft.body.position.x;
    double bLefty = buttonLeft.body.position.y;
    double bRightx = buttonRight.body.position.x;
    double bRighty = buttonRight.body.position.y;
    if(touch.x >= bRightx && touch.x <= bRightx + buttonRight.width  
      && touch.y >= bRighty && touch.y <= bRighty + buttonRight.height) {
      rosant.goingToWalkRight = true;
      rosant.goingToWalkLeft = false;
      rosant.direction = RosantDirection.right;
      buttonRight.updateSprite(0.5);
      buttonLeft.updateSprite(1);
      return true;
    } else if (touch.x >= bLeftx && touch.x < bLeftx + buttonLeft.width
      && touch.y >= bLefty && touch.y <= bLefty + buttonLeft.height) {
      rosant.goingToWalkLeft = true;
      rosant.goingToWalkRight = false;
      rosant.direction = RosantDirection.left;
      buttonLeft.updateSprite(0.5);
      buttonRight.updateSprite(1);
      return true;
    } else {
      return false;
    }
  }
  static bool checkJumpCondition(Rosant rosant, Vector2 touch, ButtonJump buttonJump) {
    if(rosant.life <= 0) return false;
    final bx = buttonJump.body.position.x;
    final by = buttonJump.body.position.y;
    if(touch.x >= bx && touch.x <= bx + buttonJump.width  
      && touch.y >= by && touch.y <= by + buttonJump.height
      ) {
        rosant.goingToJump = true;
        buttonJump.updateSprite(0.5);
        return true;
    } else {
      return false;
    }
  }
  static bool checkShootCondition(Rosant rosant, Vector2 touch, ButtonShoot buttonShoot){
    if(rosant.life <= 0) return false;
    final bx = buttonShoot.body.position.x;
    final by = buttonShoot.body.position.y;
    if(touch.x >= bx && touch.x <= bx + buttonShoot.width  
      && touch.y >= by && touch.y <= by + buttonShoot.height
      ) {
        buttonShoot.updateSprite(0.5);
        return true;
    } else {
      return false;
    }
  }

}
