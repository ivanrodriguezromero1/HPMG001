import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import '/game/epicron_stateful_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MaterialApp(
    home: EpicronStatefulWidget()),
  );
}