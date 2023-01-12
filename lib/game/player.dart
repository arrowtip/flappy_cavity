import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_cavity/game/bone_obstacle_upper.dart';
import 'package:flappy_cavity/game/flappy_cavity.dart';
import 'package:flutter/foundation.dart';

import 'bone_obstacle_lower.dart';

class Player extends SpriteComponent
    with HasGameRef<FlappyCavity>, CollisionCallbacks {
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(FlappyCavity.playerSprite);
    width = 7 * FlappyCavity.pixelRatio;
    height = 6 * FlappyCavity.pixelRatio;
    anchor = Anchor.center;
    hitbox = RectangleHitbox(isSolid: true)
      ..collisionType = CollisionType.active;
    add(hitbox);
  }

  void move(double newPos) {
    position.y = newPos;
  }

  @override
  update(double dt) {
    position.y =
        (gameRef.size.y / (gameRef.maxHeartRate - gameRef.minHeartRate)) *
            (gameRef.maxHeartRate -
                clampDouble(
                    gameRef.earBudService.bpm,
                    gameRef.minHeartRate.toDouble(),
                    gameRef.maxHeartRate.toDouble()));

    // position.y = gameRef.size.y / 2;
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is BoneObstacleLower || other is BoneObstacleUpper) {
      gameRef.gameEnded();
      gameRef.overlays.add("GameOver");
    }
  }
}
