import 'dart:math';
import 'package:flame/components.dart';
import 'package:hpmg001/models/aliens/alien_direction.dart';
import 'package:hpmg001/models/scenery/screen.dart';
import '/models/aliens/alien.dart';
import '/models/rosant/rosant.dart';

class AlienService {
  static void walk(Alien alien, Rosant rosant){
    if(!alien.isFallen && rosant.life != 0){
      if(alien.body.position.x > rosant.body.position.x){
        alien.direction = AlienDirection.left;
        alien.body.linearVelocity = Vector2(-3, alien.body.linearVelocity.y);
      }else if(alien.body.position.x < rosant.body.position.x){
        alien.direction = AlienDirection.right;
        alien.body.linearVelocity = Vector2(3, alien.body.linearVelocity.y);
      }
    }
  }
  static void standUp(Alien alien, double dt){
    int angleInDegrees = (alien.body.angle*180/pi).round().abs();
    alien.isFallen = angleInDegrees >= 89 && angleInDegrees <= 91;
    if(alien.isFallen){
      alien.elapsedTimeSinceFall += dt;
    }
    if(alien.elapsedTimeSinceFall >= 1){
      // alien.body.setTransform(alien.body.position, 0);
      alien.elapsedTimeSinceFall = 0;
    }
  }
  static void contact(Alien alien, Rosant rosant, double dt){
    if(alien.isContacted){
      alien.elapsedTimeSinceContact += dt;
    }
    if(alien.elapsedTimeSinceContact >= 1){
      if(rosant.life >= 1) {
        rosant.life--;
      }
      alien.elapsedTimeSinceContact = 0;
    }
  }
  static void fallenOut(Alien alien){
    if(alien.body.position.y >= Screen.worldSize.y){
      alien.life = 0;
    }
  }
}