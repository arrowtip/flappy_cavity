import 'dart:math';

import 'package:flame/components.dart';
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
  final int _minGapWidth;
  final int _minHeartRate;
  final int _maxHeartRate;
  int _gameDurationSec = 0;
  int _barriersPassed = 0;
  late TimerComponent _durationTimerComp;
  late TimerComponent _obstacleTimerComp;

  FlappyCavity(this._earbudService,
      {int minHeartRate = 50, int maxHeartRate = 200, int minGapWidth = 30})
      : _minHeartRate = minHeartRate,
        _maxHeartRate = maxHeartRate,
        _minGapWidth = minGapWidth {
    _obstacleTimerComp = TimerComponent(
        period: 45, repeat: true, onTick: _addObstacle, autoStart: false);
    add(_obstacleTimerComp);
    _durationTimerComp = TimerComponent(
        period: 1,
        onTick: () => _gameDurationSec++,
        repeat: true,
        autoStart: false);
    add(_durationTimerComp);
  }

  void _addObstacle() {
    double gapWidth =
        Random().nextDouble() * (1 / (1 + _gameDurationSec)) * size.y +
            _minGapWidth;
    double position =
        Random().nextDouble() * (size.y - 2 * _minGapWidth) + _minGapWidth;
    BoneObstacleLower obstacle = BoneObstacleLower(
        lower: position + gapWidth / 2, upper: position - gapWidth / 2)
      ..priority = 2;

    add(obstacle);
  }

  void _initializeGame() {
    add(Player()
      ..priority = 3
      ..x = size.x / 8
      ..y = size.y / 2);
    add(Hud()
      ..position = Vector2(0, 0)
      ..priority = 4);

    _obstacleTimerComp.timer.start();
    _durationTimerComp.timer.start();
    _addObstacle();
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
    _durationTimerComp.timer.reset();
    _obstacleTimerComp.timer.reset();
    await onLoad();
  }

  void gameEnded() async {
    pauseEngine();

    RecordModel record = RecordModel(
        Duration(seconds: _gameDurationSec), DateTime.now(), _barriersPassed);
    await insertRecordIntoDatabase(record);
  }
}
