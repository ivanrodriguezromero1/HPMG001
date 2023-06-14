import '/services/alien_services.dart';
import '/models/aliens/alien.dart';
import '/models/rosant/rosant.dart';

class AlienController{
  static void walk(Alien alien, Rosant rosant){
    return AlienService.walk(alien, rosant);
  }
  static void standUp(Alien alien, double dt){
    return AlienService.standUp(alien, dt);
  }
  static void contact(Alien alien, Rosant rosant, double dt){
    return AlienService.contact(alien, rosant, dt);
  }
  static void fallenOut(Alien alien){
    return AlienService.fallenOut(alien);
  }
}