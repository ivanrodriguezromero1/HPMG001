import 'dart:math';
import '/models/aliens/alien_type.dart';
import '/models/aliens/alien_type_a.dart';
import '/models/aliens/alien_type_b.dart';
import '/models/aliens/alien_type_c.dart';
import '/models/aliens/alien_configuration.dart';

class AlienFactory{
  static AlienConfiguration createRandomAlien(){
    AlienType type;
    int randomIndex = Random().nextInt(3);
    // randomIndex = 2;
    switch(randomIndex){
      case 0:
        type = AlienType.typeA;
        break;
      case 1:
        type = AlienType.typeB;
        break;
      default:
        type = AlienType.typeC;
        break;
    }
    switch(type){
      case AlienType.typeA:
        return TypeA();
      case AlienType.typeB:
        return TypeB();
      case AlienType.typeC:
      return TypeC();
    }
  } 
}