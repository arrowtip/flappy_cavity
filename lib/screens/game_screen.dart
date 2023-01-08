import 'package:flappy_cavity/services/earbud_service.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final EarbudService earbudService;

  const GameScreen(this.earbudService, {Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          initialData: 0,
          stream: widget.earbudService.bpmStream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Text("Counter: ${snapshot.data}")
                : const Text("No Counter Value");
          },
        ),
      ),
    );
  }
}
