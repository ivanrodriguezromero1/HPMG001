import '/models/rosant/rosant.dart';
import '/models/scenery/background.dart';
import '/services/background_services.dart';

class BackgroundController {
  static void move(Background background, Rosant rosant){
    return BackgroundServices.move(background, rosant);
  }
}