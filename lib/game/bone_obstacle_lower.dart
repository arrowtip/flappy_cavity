import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_cavity/game/bone_obstacle_upper.dart';
import 'package:flappy_cavity/game/flappy_cavity.dart';

class BoneObstacleLower extends SpriteComponent with HasGameRef<FlappyCavity> {
  late ShapeHitbox _hitbox;
  late BoneObstacleUpper _upperPart;
  double lower;
  double upper;

  BoneObstacleLower({required this.lower, required this.upper});
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(FlappyCavity.boneLowerSprite);
    width = 12 * FlappyCavity.pixelRatio;
    height = 200 * FlappyCavity.pixelRatio;
    anchor = Anchor.topCenter;
    position.y = lower;
    position.x = gameRef.size.x + width;
    _hitbox = RectangleHitbox(isSolid: true)
      ..collisionType = CollisionType.passive;
    add(_hitbox);

    _upperPart = BoneObstacleUpper()
      ..position = Vector2(width / 2, upper - lower);
    add(_upperPart);
  }

  @override
  void update(double dt) {
    position.x -= dt * 10;
    if (position.x < -width) {
      removeFromParent();
    }
    super.update(dt);
  }
}
