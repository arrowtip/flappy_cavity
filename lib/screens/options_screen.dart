import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  int _minimalHeartRate = 60;
  int _maxHeartRate = 180;
  int _minGapWidth = 30;

  @override
  Widget build(BuildContext context) {
    return SettingsList(sections: [
      SettingsSection(
        title: Text("Your Heart"),
        tiles: [
          SettingsTile.navigation(
              title: Text("Heart Rate"),
              value: Text("$_minimalHeartRate - $_maxHeartRate")),
        ],
      ),
      SettingsSection(
        title: Text("Game"),
        tiles: [
          SettingsTile.navigation(
            title: Text("minimal gap width"),
            value: Text("$_minGapWidth"),
          )
        ],
      )
    ]);
  }
}
