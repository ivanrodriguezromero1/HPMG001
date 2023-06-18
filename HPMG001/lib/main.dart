import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import '/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MyApp());
}