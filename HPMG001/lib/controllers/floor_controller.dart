import '/models/rosant/rosant.dart';
import '/models/scenery/floor.dart';
import '/services/floor_services.dart';

class FloorController {
  static void move(Floor floor, Rosant rosant){
    return FloorServices.move(floor, rosant);
  }
}