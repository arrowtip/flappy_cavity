import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flappy_cavity/screens/game_screen.dart';
import 'package:flappy_cavity/screens/records_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ButtonStyle fullMenuButtonStyle = ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
            MediaQuery.of(context).size.height * 0.1),
        textStyle: const TextStyle(fontSize: 20));
    ButtonStyle halfMenuButtonStyle = ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width * 0.25 - 5,
            MediaQuery.of(context).size.height * 0.1),
        textStyle: const TextStyle(fontSize: 15));
    TextStyle titleStyle = const TextStyle(
        fontSize: 70, fontFamily: "EastSeaDokdo", color: Colors.red);

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
                    textStyle: titleStyle,
                    duration: const Duration(milliseconds: 1000),
                    scalingFactor: 0.9),
                ScaleAnimatedText("Flappy Cavity",
                    textStyle: titleStyle,
                    duration: const Duration(milliseconds: 1000),
                    scalingFactor: 0.9),
                ScaleAnimatedText("",
                    textStyle: TextStyle(
                        fontSize: 60,
                        fontFamily: "EastSeaDokdo",
                        color: Colors.black.withOpacity(0)),
                    duration: const Duration(milliseconds: 500))
              ],
              isRepeatingAnimation: true,
              repeatForever: true,
              pause: const Duration(milliseconds: 0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameScreen()));
              },
              style: fullMenuButtonStyle,
              child: const Text("new"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecordsScreen()));
                },
                style: fullMenuButtonStyle,
                child: const Text("records")),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: ElevatedButton(
                    style: halfMenuButtonStyle,
                    onPressed: () {},
                    child: const Text("options"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                  child: ElevatedButton(
                    style: halfMenuButtonStyle,
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse(
                          "https://github.com/arrowtip/flappy_cavity"))) {
                        throw "Could not launch github url";
                      }
                    },
                    child: const Text("github"),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}