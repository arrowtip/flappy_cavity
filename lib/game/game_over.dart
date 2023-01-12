import 'package:flappy_cavity/game/flappy_cavity.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key, required this.game}) : super(key: key);

  final FlappyCavity game;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: game.size.x / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () async {
                await game.reset();
              },
              child: const Text("retry"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("exit"),
            ),
          )
        ],
      ),
    ));
  }
}
