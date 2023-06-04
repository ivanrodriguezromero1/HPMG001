import 'package:flame/components.dart';
import 'package:hpmg001/models/controls/button_right.dart';
import 'package:hpmg001/models/scenery/background.dart';
import 'package:hpmg001/models/scenery/screen.dart';
import '/models/controls/button_shoot.dart';
import '../models/rosant/rosant_direction.dart';
import '/models/controls/button_jump.dart';
import '../models/controls/button_left.dart';
import '/models/rosant/rosant.dart';
import '/utils/globals.dart';

class RosantServices {
  static void jump(Rosant rosant){
      rosant.body.setTransform(rosant.body.position, 0);
      final force = Vector2(0, -7);
      rosant.body.applyLinearImpulse(force);
  }
  static void walkLeft(Rosant rosant){
    if(rosant.goingToWalkLeft){
      rosant.body.setTransform(rosant.body.position, 0);
      // if(rosant.body.position.x > Screen.worldSize.x/20){
      final force = Vector2(-0.1, 0);
      rosant.body.applyLinearImpulse(force);
    // }
    }
  }
  static void walkRight(Rosant rosant){
    if(rosant.goingToWalkRight){
      rosant.body.setTransform(rosant.body.position, 0);
      // if(rosant.body.position.x < 19*Screen.worldSize.x/20){
      final force = Vector2(0.1, 0);
      rosant.body.applyLinearImpulse(force);
      // }
    }
  }
  static bool checkWalkCondition(Rosant rosant, Vector2 touch, ButtonRight buttonRight, ButtonLeft buttonLeft) {
    double bLeftx = buttonLeft.body.position.x;
    double bLefty = buttonLeft.body.position.y;
    double bRightx = buttonRight.body.position.x;
    double bRighty = buttonRight.body.position.y;
    if(touch.x >= bRightx && touch.x <= bRightx + buttonRight.width  
      && touch.y >= bRighty && touch.y <= bRighty + buttonRight.height) {
      rosant.goingToWalkRight = true;
      rosant.goingToWalkLeft = false;
      rosant.direction = RosantDirection.right;
      return true;
    } else if (touch.x >= bLeftx && touch.x < bLeftx + buttonLeft.width
      && touch.y >= bLefty && touch.y <= bLefty + buttonLeft.height) {
      rosant.goingToWalkLeft = true;
      rosant.goingToWalkRight = false;
      rosant.direction = RosantDirection.left;
      return true;
    } else {
      return false;
    }
  }
  static bool checkJumpCondition(Rosant rosant, Vector2 touch, ButtonJump buttonJump) {
    final bx = buttonJump.body.position.x;
    final by = buttonJump.body.position.y;
    final ry = rosant.body.position.y;
    final rh = rosant.height;
    final rvy = rosant.body.linearVelocity.y;
    if(touch.x >= bx && touch.x <= bx + buttonJump.width  
      && touch.y >= by && touch.y <= by + buttonJump.height
      && rvy.round() == 0 && (horizon - rh/2 - ry).round() == 0
      ) {
        return true;
    } else {
      return false;
    }
  }
  static bool checkShootCondition(Rosant rosant, Vector2 touch, ButtonShoot buttonShoot){
    if(rosant.life > 0){
      final bx = buttonShoot.body.position.x;
      final by = buttonShoot.body.position.y;
      if(touch.x >= bx && touch.x <= bx + buttonShoot.width  
        && touch.y >= by && touch.y <= by + buttonShoot.height
        ) {
          return true;
      } else {
        return false;
      }
    }else{
      return false;
    }
  }

}
