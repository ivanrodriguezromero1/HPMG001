import '../services/alien_services.dart';
import '../models/alien.dart';
import '../models/rosant.dart';

class AlienController{
  static void walk(Alien alien, Rosant rosant){
    return AlienService.walk(alien, rosant);
  }
  static void standUp(Alien alien, Rosant rosant, double dt){
    return AlienService.standUp(alien, rosant, dt);
  }
  static void contact(Alien alien, Rosant rosant, double dt){
    return AlienService.contact(alien, rosant, dt);
  }
}