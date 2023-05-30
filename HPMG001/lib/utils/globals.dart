import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import '../models/screen.dart';

late Sprite floorSprite;
late Sprite backgroundSprite;
AudioPlayer player = AudioPlayer();
bool assetsLoaded = false;
Vector2 initialWorldLinearVelocity = Vector2(-4, 0);
double initialBladeAngularVelocity = radians(360);
Vector2 worldLinearVelocity = initialWorldLinearVelocity;
double bladeAngularVelocity = initialBladeAngularVelocity;
double horizon = 2 * Screen.worldSize.y/3;
double totalWidth = 2 * Screen.worldSize.x - 0.01;