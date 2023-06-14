import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '/game/epicron.dart';
import '/game/epicron_stateful_widget.dart';

class EpicronState extends State<EpicronStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return GameWidget.controlled(
      gameFactory: () => Epicron(),
    );
  }
}