import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '/models/rosant/rosant.dart';
import '/game/epicron.dart';

class EpicronStatelessWidget extends StatelessWidget {
  final Rosant _rosant;
  const EpicronStatelessWidget({required Rosant rosant, Key? key}) 
    : _rosant = rosant, super(key: key);
  @override
  Widget build(BuildContext context) {
    return GameWidget.controlled(
      gameFactory: () => Epicron(rosant: _rosant),
    );
  }
}