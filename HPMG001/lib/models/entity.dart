import 'package:flame_forge2d/flame_forge2d.dart';

abstract class Entity extends BodyComponent {
  bool _state = true;
  void initializing();
  @override
  void update(double dt){
    super.update(dt);
    if(!_state){
      destroyBody();
    }
  }
  void destroy(){
    _state = false;
  }
  void destroyBody(){
    world.destroyBody(body);
    gameRef.remove(this);
  }
}