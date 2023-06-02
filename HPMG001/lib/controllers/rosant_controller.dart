import 'package:flame/components.dart';
import '../models/controls/button_shoot.dart';
import '../models/controls/joystick_left.dart';
import '../models/controls/button_jump.dart';
import '../models/rosant/rosant.dart';
import '../services/rosant_services.dart';

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
  static bool checkWalkCondition(Rosant rosant, Vector2 touch, JoystickLeft joystickLeft) {
    return RosantServices.checkWalkCondition(rosant, touch, joystickLeft);
  }
  static bool checkJumpCondition(Rosant rosant, Vector2 touch, ButtonJump buttonJump) {
    return RosantServices.checkJumpCondition(rosant, touch, buttonJump);
  }
  static bool checkShootCondition(Rosant rosant, Vector2 touch, ButtonShoot buttonShoot) {
    return RosantServices.checkShootCondition(rosant, touch, buttonShoot);
  }
}
