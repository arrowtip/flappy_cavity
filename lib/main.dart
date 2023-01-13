import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'screens/home_screen.dart';

late Database database;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String databaseName = "flappy_cavity.db";
  const int databaseVersion = 1;
  database = await openDatabase(join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
    return db.execute("create table Records("
        "id integer primary key, "
        "durationSec integer not null, "
        // "date integer not null, " id is used as both date and id
        "barriersPassed integer not null)");
  }, version: databaseVersion);
  await Settings.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Cavity',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
