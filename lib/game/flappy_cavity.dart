import 'package:flame/game.dart';
import 'package:flappy_cavity/game/bone_obstacle.dart';
import 'package:flappy_cavity/game/player.dart';

// TODO add with SingleGameInstance
class FlappyCavity extends FlameGame with HasCollisionDetection {
  static const String playerSprite = "heart.png";
  static const String boneObstacleSprite = "bone.png";
  static const double pixelRatio = 4.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final playerSprite = await loadSprite(FlappyCavity.playerSprite);

    add(Player()
      ..priority = 3
      ..x = size.x / 8
      ..y = size.y / 2);
    add(BoneObstacle()
      ..x = size.x / 2
      ..y = size.y / 2
      ..priority = 2);
  }
}
