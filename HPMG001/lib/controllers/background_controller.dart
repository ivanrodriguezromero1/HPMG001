import 'package:hpmg001/models/rosant/rosant.dart';
import 'package:hpmg001/models/scenery/background.dart';
import 'package:hpmg001/services/background_service.dart';

class BackgroundController {
  static void move(Background background, Rosant rosant){
    return BackgroundService.move(background, rosant);
  }
}