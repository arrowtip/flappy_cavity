import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flappy_cavity/screens/game_screen.dart';
import 'package:flappy_cavity/screens/options_screen.dart';
import 'package:flappy_cavity/screens/records_screen.dart';
import 'package:flappy_cavity/services/earbud_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final EarbudService _earbudService;
  String _shownConnectionStatus = "disconnected";

  @override
  void initState() {
    _earbudService = EarbudService();
    super.initState();
  }

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
              onPressed: () async {
                if (_earbudService.isConnected) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen(_earbudService)));
                } else {
                  if (!await _earbudService.isBluetoothEnabled()) {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text("Bluetooth is not enabled"),
                              content: const Text("please enable it"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, "OK");
                                    },
                                    child: const Text("OK"))
                              ]);
                        });
                  } else if (!await _earbudService.isLocationEnabled()) {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text("Location is not enabled"),
                              content: const Text("please enable it"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, "OK");
                                    },
                                    child: const Text("OK"))
                              ]);
                        });
                  }
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("no heartbeat measurer connected"),
                        content: const Text(
                            "please connect your cosinuss earbud.\n"
                            "Remember to turn bluetooth and location services on"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                _earbudService.connect(
                                    onConnectStateChange: () {
                                  setState(() {
                                    _shownConnectionStatus =
                                        _earbudService.isConnected
                                            ? "connected"
                                            : "disconnected";
                                  });
                                });
                                Navigator.pop(context, "connect");
                              },
                              child: const Text("connect")),
                          TextButton(
                              onPressed: () => Navigator.pop(context, "cancel"),
                              child: const Text("cancel"))
                        ],
                      );
                    },
                  );
                }
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OptionsScreen()));
                    },
                    child: const Text("options"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                  child: ElevatedButton(
                    style: halfMenuButtonStyle,
                    onPressed: () async {
                      bool couldLaunch = false;
                      try {
                        couldLaunch = await launchUrl(Uri.parse(
                            "https://github.com/arrowtip/flappy_cavity"));
                      } catch (e) {
                        // if exception is thrown couldLaunch remains false
                      }
                      if (!couldLaunch) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text("Could not open the url"),
                                  content: const Text("To visit the github "
                                      "open a browser and go to "
                                      "\"https://github.com/arrowtip/flappy_cavity\""),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, "OK");
                                        },
                                        child: const Text("OK"))
                                  ]);
                            });
                      }
                    },
                    child: const Text("github"),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                child: Text("Connection Status:"),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(_shownConnectionStatus),
              ),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!await _earbudService.isBluetoothEnabled()) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text("Bluetooth is not enabled"),
                                  content: const Text("please enable it"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, "OK");
                                        },
                                        child: const Text("OK"))
                                  ]);
                            });
                      } else if (!await _earbudService.isLocationEnabled()) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text("Location is not enabled"),
                                  content: const Text("please enable it"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, "OK");
                                        },
                                        child: const Text("OK"))
                                  ]);
                            });
                      }
                      _earbudService.connect(onConnectStateChange: () {
                        setState(() {
                          _shownConnectionStatus = _earbudService.isConnected
                              ? "connected"
                              : "disconnected";
                        });
                      });
                    },
                    child: const Text("connect"),
                  )),
            ],
          )
        ],
      )),
    );
  }
}
