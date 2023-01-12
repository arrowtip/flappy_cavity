import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_cavity/game/flappy_cavity.dart';

class BoneObstacleUpper extends SpriteComponent with HasGameRef<FlappyCavity> {
  late ShapeHitbox _hitbox;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(FlappyCavity.boneUpperSprite);
    width = 12 * FlappyCavity.pixelRatio;
    height = 200 * FlappyCavity.pixelRatio;
    anchor = Anchor.bottomCenter;
    _hitbox = RectangleHitbox(isSolid: true)
      ..collisionType = CollisionType.passive;
    add(_hitbox);
  }
}
