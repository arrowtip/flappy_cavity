import 'package:flame/components.dart';
import 'package:flappy_cavity/game/flappy_cavity.dart';

class Player extends SpriteComponent with HasGameRef<FlappyCavity> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite("");

    x = gameRef.size.x / 2;
    y = gameRef.size.y / 2;
    width = 100;
    height = 150;
    anchor = Anchor.center;
  }

  void move(Vector2 delta) {}
}
