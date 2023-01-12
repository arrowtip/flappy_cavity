import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'flappy_cavity.dart';

class PauseButton extends SpriteComponent
    with HasGameRef<FlappyCavity>, Tappable {
  @override
  bool onTapDown(TapDownInfo info) {
    if (gameRef.overlays.isActive("PauseMenu")) {
      gameRef.overlays.remove("PauseMenu");
      gameRef.resumeEngine();
    } else if (!gameRef.overlays.isActive("GameOver")) {
      gameRef.overlays.add("PauseMenu");
      gameRef.pauseEngine();
    }
    return super.onTapDown(info);
  }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(FlappyCavity.pauseButtonSprite);
    width = 30;
    height = 30;
    anchor = Anchor.topRight;

    await super.onLoad();
  }
}
