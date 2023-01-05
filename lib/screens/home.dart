import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("Flappy Cavity",
              style: TextStyle(), textAlign: TextAlign.center),
          ElevatedButton(onPressed: () {}, child: Text("new")),
          ElevatedButton(onPressed: () {}, child: Text("records"))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      )),
    );
  }
}
