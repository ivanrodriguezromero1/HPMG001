import 'package:flame/components.dart';
import 'package:juego_ingeniero/models/button_shoot.dart';
import 'package:juego_ingeniero/models/direction.dart';
import '../models/button_jump.dart';
import '../models/joystick_left.dart';
import '../models/rosant.dart';
import '../utils/globals.dart';

class RosantServices {
  static void jump(Rosant rosant){
      rosant.body.setTransform(rosant.body.position, 0);
      final force = Vector2(0, -20);
      rosant.body.applyLinearImpulse(force);
  }
  static void walkLeft(Rosant rosant){
    rosant.body.setTransform(rosant.body.position, 0);
    // rosant.body.linearVelocity = Vector2(-1, rosant.body.linearVelocity.y);
    final force = Vector2(-1, 0);
    rosant.body.applyLinearImpulse(force);
  }
  static void walkRight(Rosant rosant){
    rosant.body.setTransform(rosant.body.position, 0);
    // rosant.body.linearVelocity = Vector2(1, rosant.body.linearVelocity.y);
    final force = Vector2(1, 0);
    rosant.body.applyLinearImpulse(force);
  }
  static bool checkWalkCondition(Rosant rosant, Vector2 touch, JoystickLeft joystickLeft) {
    final jx = joystickLeft.body.position.x;
    final jy = joystickLeft.body.position.y;
    if(touch.x >= jx + joystickLeft.width/2 && touch.x <= jx + joystickLeft.width  
      && touch.y >= jy && touch.y <= jy + joystickLeft.height) {
      rosant.goingToWalkRight = true;
      rosant.goingToWalkLeft = false;
      rosant.direction = Direction.right;
      return true;
    } else if (touch.x >= jx && touch.x < jx + joystickLeft.width/2 
      && touch.y >= jy && touch.y <= jy + joystickLeft.height) {
      rosant.goingToWalkLeft = true;
      rosant.goingToWalkRight = false;
      rosant.direction = Direction.left;
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
  static bool checkShootCondition(Vector2 touch, ButtonShoot buttonShoot){
    final bx = buttonShoot.body.position.x;
    final by = buttonShoot.body.position.y;
    if(touch.x >= bx && touch.x <= bx + buttonShoot.width  
      && touch.y >= by && touch.y <= by + buttonShoot.height
      ) {
        return true;
    } else {
      return false;
    }
  }

}
