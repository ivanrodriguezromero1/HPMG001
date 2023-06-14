import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:hpmg001/models/category_bits.dart';
import 'package:hpmg001/models/scenery/screen.dart';
import '/models/entity.dart';

abstract class Projectile extends Entity with ContactCallbacks {
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    destroy();
    Filter newFilter = Filter();
    newFilter.maskBits = CategoryBits.none;
    for (Fixture fixture in body.fixtures) {
      fixture.filterData = newFilter;
    }
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(body.position.x < 0 || body.position.x > Screen.worldSize.x){
      destroyBody();
    }
  }
}