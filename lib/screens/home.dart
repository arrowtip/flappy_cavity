import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: AnimatedTextKit(
              animatedTexts: [
                ScaleAnimatedText("Flappy Cavity",
                    textStyle: const TextStyle(
                        fontSize: 60,
                        fontFamily: "EastSeaDokdo",
                        color: Colors.red),
                    duration: const Duration(milliseconds: 500),
                    scalingFactor: 0.8),
                ScaleAnimatedText("Flappy Cavity",
                    textStyle: const TextStyle(
                        fontSize: 60,
                        fontFamily: "EastSeaDokdo",
                        color: Colors.red),
                    duration: const Duration(milliseconds: 500),
                    scalingFactor: 0.8),
                ScaleAnimatedText("",
                    textStyle: TextStyle(
                        fontSize: 60,
                        fontFamily: "EastSeaDokdo",
                        color: Colors.black.withOpacity(0)),
                    duration: const Duration(milliseconds: 300))
              ],
              isRepeatingAnimation: true,
              repeatForever: true,
              pause: const Duration(milliseconds: 0),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("new")),
          ElevatedButton(onPressed: () {}, child: const Text("records"))
        ],
      )),
    );
  }
}
