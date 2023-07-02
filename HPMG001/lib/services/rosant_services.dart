import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hpmg001/models/rosant/rosant_bullet.dart';
import 'package:hpmg001/utils/animations.dart';
import 'package:hpmg001/utils/globals.dart';
import 'package:hpmg001/utils/horizontal_orientation.dart';
import '/models/controls/button_right.dart';
import '/models/controls/button_shoot.dart';
import '../utils/character_state.dart';
import '/models/controls/button_jump.dart';
import '/models/controls/button_left.dart';
import '/models/rosant/rosant.dart';

class RosantServices {
  static void jump(Rosant rosant){
    if(rosant.goingToJump && rosant.canJump){
      final force = Vector2(0, -600);
      rosant.body.applyLinearImpulse(force);
    }
  }
  static void walkLeft(Rosant rosant){
    if(rosant.goingToWalkLeft){
      final force = Vector2(-40, 0);
      rosant.body.applyLinearImpulse(force);
    }
  }
  static void walkRight(Rosant rosant){
    if(rosant.goingToWalkRight){
      final force = Vector2(40, 0);
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
      rosant.state = CharacterState.idleRight;
      buttonRight.updateSprite(0.5);
      buttonLeft.updateSprite(1);
      return true;
    } else if (touch.x >= bLeftx && touch.x < bLeftx + buttonLeft.width
      && touch.y >= bLefty && touch.y <= bLefty + buttonLeft.height) {
      rosant.goingToWalkLeft = true;
      rosant.goingToWalkRight = false;
      rosant.state = CharacterState.idleLeft;
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
  static void performMovement(Rosant rosant, Offset unitVector) {
    if(rosant.renderBody == true) return;
    if(rosant.life <= 0) return;
    double maxSpeedX = 20;
    double maxSpeedY = 60;
    double speedX = maxSpeedX*unitVector.dx;
    double speedY = (rosant.canJump)
      ? maxSpeedY*unitVector.dy : rosant.body.linearVelocity.y;
    rosant.body.linearVelocity = Vector2(speedX, speedY);    
  }
  static void setMovingState(Rosant rosant, Offset unitVector) {
    if(rosant.life <= 0) return;
    double angle = degrees(unitVector.direction);
    if(angle >= -90 && angle <= 90) {
      rosant.stateUpdate = CharacterState.walkRight;
      rosant.horizontalOrientation = HorizontalOrientation.right;
    } else {
      rosant.stateUpdate = CharacterState.walkLeft;
      rosant.horizontalOrientation = HorizontalOrientation.left;
    }
  }
  static void setIdleState(Rosant rosant) {
    if(rosant.life <= 0) return;
    final horizontalOrientation = rosant.horizontalOrientation;
    if(horizontalOrientation == HorizontalOrientation.right) {
      rosant.stateUpdate = CharacterState.idleRight;
    } else {
      rosant.stateUpdate = CharacterState.idleLeft;
    }
  }
  static void updateRosantAnimation(Rosant rosant) {
    if (rosant.state != rosant.stateUpdate) {
      rosant.remove(rosant.animation);
      final List<int> range = rosant.rosantStateRanges[rosant.stateUpdate] ?? [];
      rosant.animation = Animations.generateCharacterAnimations(
        sprites: Globals.rosantSprites.sublist(range[0], range[1]),
        width: rosant.width,
        height: rosant.height,
      );
      rosant.add(rosant.animation);
      rosant.state = rosant.stateUpdate;
    }
  }
  static void dontFall(Rosant rosant) {
    if (rosant.body.angle.round() != 0) {
      double targetAngle = 0;
      double angleDiff = targetAngle - rosant.body.angle;
      rosant.body.angularVelocity = 3*angleDiff;
    }
  }
  static double calculateBulletXPosition(Rosant rosant) {
    double x = rosant.body.position.x + rosant.width / 2;
    if (rosant.horizontalOrientation == HorizontalOrientation.right) {
      x += rosant.width / 2;
    } else {
      x -= rosant.width / 2;
    }
    return x;
  }
  static double calculateBulletYPosition(Rosant rosant) {
    return rosant.body.position.y + rosant.height / 1.5;
  }
  static void shoot(Rosant rosant, Offset unitVector) {
    if(rosant.renderBody == true) return;
    if(rosant.life<=0) return;
    double x = calculateBulletXPosition(rosant);
    double y = calculateBulletYPosition(rosant);
    if(rosant.canShoot) {
      rosant.canShoot = false;
      rosant.gameRef.add(
        RosantBullet(
          x: x,
          y: y,
          unitVector: unitVector,
        )
      );
      Future.delayed(const Duration(milliseconds: 250), () {
        rosant.canShoot = true;
      });
    }
  }
}
