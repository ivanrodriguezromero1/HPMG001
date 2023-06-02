import 'dart:math';
import '../models/alien_type.dart';
import '../models/alien_type_a.dart';
import '../models/alien_type_b.dart';
import '../models/alien_configuration.dart';

class AlienFactory{
  static AlienConfiguration createRandomAlien(){
    AlienType type = Random().nextInt(2) == 0 ? AlienType.typeA : AlienType.typeB;
    switch(type){
      case AlienType.typeA:
        return TypeA();
      case AlienType.typeB:
        return TypeB();
      default:
        return TypeA();
    }
  } 
}