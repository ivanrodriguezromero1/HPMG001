import 'package:flame_forge2d/flame_forge2d.dart';
import '/models/category_bits.dart';
import '/models/scenery/screen.dart';
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
}