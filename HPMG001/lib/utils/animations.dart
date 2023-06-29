import 'package:flame/components.dart';

class Animations {
  static SpriteAnimationComponent generateCharacterAnimations({
    required List<Sprite> sprites, 
    required double width, 
    required double height
    }
  ) {
    final spriteAnimation = SpriteAnimation.spriteList(
      sprites, 
      stepTime: 0.08, 
      loop: true);
    return SpriteAnimationComponent(
      animation: spriteAnimation,
      size: Vector2(width, height),
      position: Vector2.zero(),
      anchor: Anchor.topLeft,
      removeOnFinish: false,
    );
  }
}