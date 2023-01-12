import 'package:flame/components.dart';
import 'package:flappy_cavity/game/flappy_cavity.dart';
import 'package:flappy_cavity/game/pause_button.dart';
import 'package:flutter/material.dart';

class Hud extends PositionComponent with HasGameRef<FlappyCavity> {
  late TextComponent _bpmMeter;
  late PauseButton _pauseButton;

  @override
  Future<void> onLoad() async {
    _bpmMeter = TextComponent(
        text: "${gameRef.earBudService.bpm.round()}",
        textRenderer: TextPaint(
            style: const TextStyle(fontSize: 30, color: Colors.white)),
        anchor: Anchor.topCenter)
      ..position = Vector2(gameRef.size.x / 2, 5);
    add(_bpmMeter);
    _pauseButton = PauseButton()..position = Vector2(gameRef.size.x - 5, 5);
    add(_pauseButton);
  }

  @override
  void update(double dt) {
    _bpmMeter.text = "${gameRef.earBudService.bpm.round()}";
    super.update(dt);
  }
}
