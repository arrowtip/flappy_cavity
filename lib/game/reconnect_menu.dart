import 'package:flappy_cavity/game/flappy_cavity.dart';
import 'package:flutter/material.dart';

class ReconnectMenu extends StatelessWidget {
  const ReconnectMenu({Key? key, required this.game}) : super(key: key);

  final FlappyCavity game;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(5),
          child: Center(
            child: Text(
              "earbud disconnected!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: () async {
              if (game.earBudService.isConnected) {
                _reconnected();
              } else {
                game.earBudService.connect(onConnectStateChange: _reconnected);
              }
            },
            child: const Text("reconnect"),
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
    ));
  }

  void _reconnected() {
    game.resumeEngine();
    game.overlays.remove("ReconnectMenu");
  }
}
