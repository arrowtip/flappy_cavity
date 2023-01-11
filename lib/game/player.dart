import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_cavity/game/bone_obstacle.dart';
import 'package:flappy_cavity/game/flappy_cavity.dart';

class Player extends SpriteComponent
    with HasGameRef<FlappyCavity>, CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(FlappyCavity.playerSprite);
    width = 7 * FlappyCavity.pixelRatio;
    height = 6 * FlappyCavity.pixelRatio;
    anchor = Anchor.center;
  }

  void move(double newPos) {
    position.y = newPos;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BoneObstacle) {
      print("collision");
    }
  }
}
