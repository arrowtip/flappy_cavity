import 'package:flame/components.dart';
import 'package:flappy_cavity/game/flappy_cavity.dart';
import 'package:flutter/material.dart';

class Hud extends PositionComponent with HasGameRef<FlappyCavity> {
  late TextComponent _bpmMeter;
  @override
  Future<void> onLoad() async {
    _bpmMeter = TextComponent(
        text: "${gameRef.earBudService.bpm.round()}",
        textRenderer: TextPaint(
            style: const TextStyle(fontSize: 30, color: Colors.white)),
        anchor: Anchor.topLeft);
    add(_bpmMeter);
  }

  @override
  void update(double dt) {
    _bpmMeter.text = "${gameRef.earBudService.bpm.round()}";
    super.update(dt);
  }
}
