import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:hpmg001/models/controls/controls_units.dart';

class Button extends FlameGame with HasTappables{
  final Sprite _sprite;
  final Vector2 _position;
  final void Function() _onPressed;
  final void Function() _onReleased;
  final void Function() _onCancelled;
  Button(
    { 
      required Sprite sprite,
      required Vector2 position,
      required void Function() onPressed,
      required void Function() onReleased,
      required void Function() onCancelled,
    }): 
    _position = position, 
    _sprite = sprite,
    _onPressed = onPressed,
    _onReleased = onReleased,
    _onCancelled = onCancelled;

  late ButtonComponent button;
  @override
  Future<void> onLoad() async {
    button = ButtonComponent(
      button: SpriteComponent(
        sprite: _sprite,
        size: Vector2(ControlsUnits.width, ControlsUnits.height)
      ),
      buttonDown: SpriteComponent(
        sprite: _sprite,
        size: Vector2(ControlsUnits.width, ControlsUnits.height),
        paint: Paint()..color = const Color.fromARGB(150, 255, 255, 255)
      ),
      position: _position,
      onPressed: _onPressed,
      onReleased: _onReleased,
      onCancelled: _onCancelled,
    );
    priority = 20;
    add(button);
  }
}