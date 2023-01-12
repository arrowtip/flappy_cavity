import 'package:flame/game.dart';
import 'package:flappy_cavity/game/bone_obstacle_lower.dart';
import 'package:flappy_cavity/game/hud.dart';
import 'package:flappy_cavity/game/player.dart';
import 'package:flappy_cavity/models/record_model.dart';
import 'package:flappy_cavity/services/database_service.dart';
import 'package:flappy_cavity/services/earbud_service.dart';

// TODO add with SingleGameInstance
class FlappyCavity extends FlameGame with HasCollisionDetection, HasTappables {
  final EarbudService _earbudService;
  static const String playerSprite = "heart.png";
  static const String boneLowerSprite = "bone_lower.png";
  static const String boneUpperSprite = "bone_upper.png";
  static const String pauseButtonSprite = "pause_button.png";
  static const double pixelRatio = 4.0;
  final int _minHeartRate;
  final int _maxHeartRate;
  late DateTime _gameStart;
  int _barriersPassed = 0;

  FlappyCavity(this._earbudService,
      {int minHeartRate = 50, int maxHeartRate = 200})
      : _minHeartRate = minHeartRate,
        _maxHeartRate = maxHeartRate;

  void _initializeGame() {
    add(Player()
      ..priority = 3
      ..x = size.x / 8
      ..y = size.y / 2);
    add(BoneObstacleLower(lower: size.y * 0.75, upper: size.y * 0.25)
      ..x = size.x / 2
      ..y = size.y / 2
      ..priority = 2);
    add(Hud()
      ..position = Vector2(0, 0)
      ..priority = 4);

    _gameStart = DateTime.now();
  }

  void barrierPassed() {
    _barriersPassed++;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _initializeGame();
  }

  int get minHeartRate => _minHeartRate;
  int get maxHeartRate => _maxHeartRate;
  EarbudService get earBudService => _earbudService;

  Future<void> reset() async {
    resumeEngine();
    removeAll(children);
    _barriersPassed = 0;
    await onLoad();
  }

  void gameEnded() async {
    pauseEngine();
    RecordModel record =
        RecordModel(DateTime.now().difference(_gameStart), DateTime.now(), 10);
    print(record.duration);
    print(record.date);
    await insertRecordIntoDatabase(record);
    print("record added");
  }
}
