import 'dart:math';
import '/models/aliens/alien.dart';
import '/models/rosant/rosant.dart';
import '/models/aliens/alien_bullet.dart';

class AlienAddWorld {
  late int _alienCount;
  late int maximumAlienCount;
  final Rosant _rosant;
  AlienAddWorld({required Rosant rosant})
    :_rosant = rosant {
    _alienCount = 0;
    maximumAlienCount = 0;
  }
  void addAliens(Function add) {
    int interval = Random().nextInt(4) + 4;
    Future.delayed(Duration(seconds: interval), () {
      if(_alienCount < maximumAlienCount
        && _rosant.life > 0){
          Alien alien = Alien(rosant: _rosant);
          add(alien);
          // addAlienBullet(alien, add);
          _alienCount++;
          addAliens(add);
        } else {
        _alienCount = 0;
      }
    });
  }
  void addAlienBullet(Alien alien, Function add) {
    int interval = Random().nextInt(2) + 2;    
    Future.delayed(Duration(seconds: interval), (){
    if(alien.life > 0 && _rosant.life > 0){
        add(AlienBullet(alien: alien));
        addAlienBullet(alien, add);
      }
    });
  }
}