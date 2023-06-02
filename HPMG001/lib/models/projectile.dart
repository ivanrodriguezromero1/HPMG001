import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:hpmg001/models/scenery/screen.dart';
import '/models/entity.dart';

abstract class Projectile extends Entity with ContactCallbacks {
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    destroy();
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(body.position.x < 0 || body.position.x > Screen.worldSize.x){
      destroyBody();
    }
  }
}