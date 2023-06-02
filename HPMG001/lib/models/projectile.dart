import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/entity.dart';

abstract class Projectile extends Entity with ContactCallbacks {
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    destroy();
  }
}