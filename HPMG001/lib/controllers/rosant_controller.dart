import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '/models/controls/button_right.dart';
import '/models/controls/button_shoot.dart';
import '/models/controls/button_left.dart';
import '/models/controls/button_jump.dart';
import '/models/rosant/rosant.dart';
import '/services/rosant_services.dart';

class RosantController {
  static void jump(Rosant rosant){
    RosantServices.jump(rosant);
  }
  static void walkLeft(Rosant rosant){
    RosantServices.walkLeft(rosant);
  }
  static void walkRight(Rosant rosant){
    RosantServices.walkRight(rosant);
  }
  static bool checkWalkCondition(Rosant rosant, Vector2 touch, ButtonRight buttonRight, ButtonLeft buttonLeft) {
    return RosantServices.checkWalkCondition(rosant, touch, buttonRight ,buttonLeft);
  }
  static bool checkJumpCondition(Rosant rosant, Vector2 touch, ButtonJump buttonJump) {
    return RosantServices.checkJumpCondition(rosant, touch, buttonJump);
  }
  static bool checkShootCondition(Rosant rosant, Vector2 touch, ButtonShoot buttonShoot) {
    return RosantServices.checkShootCondition(rosant, touch, buttonShoot);
  }
  static void performMovement(Rosant rosant, {Offset unitVector = Offset.zero}) {
    return RosantServices.performMovement(rosant, unitVector);
  }
  static void setMovingState(Rosant rosant, Offset unitVector) {
    return RosantServices.setMovingState(rosant, unitVector);
  }
  static void setIdleState(Rosant rosant) {
    return RosantServices.setIdleState(rosant);
  }
  static void updateRosantAnimation(Rosant rosant) {
    return RosantServices.updateRosantAnimation(rosant);
  }
  static void dontFall(Rosant rosant) {
    return RosantServices.dontFall(rosant);
  }
  static double calculateBulletXPosition(Rosant rosant) {
    return RosantServices.calculateBulletXPosition(rosant);
  }
  static double calculateBulletYPosition(Rosant rosant) {
    return RosantServices.calculateBulletYPosition(rosant);
  }
  static void shoot(Rosant rosant, Offset unitVector) {
    return RosantServices.shoot(rosant, unitVector);
  }
}
