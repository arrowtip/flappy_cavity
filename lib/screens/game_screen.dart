import 'package:flame/game.dart';
import 'package:flappy_cavity/services/earbud_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../game/flappy_cavity.dart';

class GameScreen extends StatefulWidget {
  final EarbudService _earbudService;

  const GameScreen(this._earbudService, {Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: FlappyCavity(widget._earbudService));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
}
