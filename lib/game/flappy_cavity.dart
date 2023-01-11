import 'package:flame/game.dart';
import 'package:flappy_cavity/game/bone_obstacle.dart';
import 'package:flappy_cavity/game/player.dart';
import 'package:flappy_cavity/services/earbud_service.dart';

// TODO add with SingleGameInstance
class FlappyCavity extends FlameGame with HasCollisionDetection {
  EarbudService _earbudService;
  static const String playerSprite = "heart.png";
  static const String boneObstacleSprite = "bone.png";
  static const double pixelRatio = 4.0;
  final int _minHeartRate;
  final int _maxHeartRate;

  FlappyCavity(this._earbudService,
      {int minHeartRate = 50, int maxHeartRate = 200})
      : _minHeartRate = minHeartRate,
        _maxHeartRate = maxHeartRate;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Player()
      ..priority = 3
      ..x = size.x / 8
      ..y = size.y / 2);
    add(BoneObstacle()
      ..x = size.x / 2
      ..y = size.y / 2
      ..priority = 2);
  }

  int get minHeartRate => _minHeartRate;
  int get maxHeartRate => _maxHeartRate;
  EarbudService get earBudService => _earbudService;
}
