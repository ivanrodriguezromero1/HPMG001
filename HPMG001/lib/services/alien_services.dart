import 'dart:math';

import 'package:flame/components.dart';
import 'package:juego_ingeniero/models/alien.dart';
import 'package:juego_ingeniero/models/rosant.dart';

class AlienService {
  static void walk(Alien alien, Rosant rosant){
    if(!alien.isFallen){
      if(alien.body.position.x > rosant.body.position.x){
        alien.body.linearVelocity = Vector2(-1, 0);
      }else if(alien.body.position.x < rosant.body.position.x){
        alien.body.linearVelocity = Vector2(1, 0);
      }
    }
  }
  static void standUp(Alien alien, Rosant rosant, double dt){
    int angleInDegrees = (alien.body.angle*180/pi).round().abs();
    alien.isFallen = angleInDegrees >= 89 && angleInDegrees <= 91;
    if(alien.isFallen){
      alien.elapsedTimeSinceFall += dt;
    }
    if(alien.elapsedTimeSinceFall >= 1){
      alien.body.setTransform(alien.body.position, 0);
      alien.elapsedTimeSinceFall = 0;
    }
  }
  static void contact(Alien alien, Rosant rosant, double dt){
    if(alien.isContacted){
      alien.elapsedTimeSinceContact += dt;
    }
    if(alien.elapsedTimeSinceContact >= 1){
      rosant.life--;
      alien.elapsedTimeSinceContact = 0;
    }
  }
}