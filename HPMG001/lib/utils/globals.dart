import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import '/models/scenery/screen.dart';

late Sprite floorSprite;
late Sprite backgroundSprite;
late Sprite leftArrowSprite;
AudioPlayer player = AudioPlayer();
bool assetsLoaded = false;
Vector2 initialWorldLinearVelocity = Vector2(-4, 0);
double initialBladeAngularVelocity = radians(360);
Vector2 worldLinearVelocity = initialWorldLinearVelocity;
double bladeAngularVelocity = initialBladeAngularVelocity;
double horizon = Screen.worldSize.y - Screen.worldSize.y/4; // 2 * Screen.worldSize.y/3
double buttonUnit = (Screen.worldSize.y - horizon)/3;