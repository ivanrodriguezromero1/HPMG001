import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/scenery/screen.dart';

class CameraConfigurator {
  static void configCamera(Camera camera){
    double width = 836;
    double height = 393;
    Screen.setScreenSize(Vector2(width, height));
    camera.viewport = FixedResolutionViewport(Screen.cameraSize);
  }
  static void updateCameraMovement(Camera camera, Body body) {
    if (CameraConfigurator.isCameraMoveAllowed(body)) {
      camera.followVector2(Vector2(body.position.x, Screen.worldSize.y / 2));
    }
  }
  static bool isCameraMoveAllowed(Body body){
    bool isLeftRestricted  = isInRange(body, 0, Screen.worldSize.x/2);
    bool isRightRestricted = isInRange(body, 1.5*Screen.worldSize.x, 2*Screen.worldSize.x);
    bool isRestricted = isLeftRestricted || isRightRestricted;
    return  !isRestricted;
  }
  static bool isInRange(Body body, double minX, double maxX) {
    return (body.position.x >= minX) && (body.position.x <= maxX);
  }
}