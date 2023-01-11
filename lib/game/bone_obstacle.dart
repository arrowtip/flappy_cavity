import 'package:flame/components.dart';
import 'package:flappy_cavity/game/flappy_cavity.dart';

class BoneObstacle extends SpriteComponent with HasGameRef<FlappyCavity> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(FlappyCavity.boneObstacleSprite);
    width = 12 * FlappyCavity.pixelRatio;
    height = 200 * FlappyCavity.pixelRatio;
    anchor = Anchor.topCenter;
  }
}
