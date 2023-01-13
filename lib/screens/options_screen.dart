import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  double _defaultMinHeartRate = 60;
  double _defaultMaxHeartRate = 180;
  double _defaultMinGapWidth = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Options"),
      ),
      body: SettingsContainer(children: [
        SettingsGroup(
          title: "Your Heart",
          children: [
            SliderSettingsTile(
              title: "minimum heart rate",
              settingKey: "min-heart-rate",
              defaultValue: _defaultMinHeartRate,
              min: 50,
              max: 110,
              step: 1,
              leading: Icon(Icons.monitor_heart_outlined),
            ),
            SliderSettingsTile(
              title: "maximum heart rate",
              settingKey: "max-heart-rate",
              defaultValue: _defaultMaxHeartRate,
              min: 130,
              max: 210,
              step: 1,
              leading: Icon(Icons.monitor_heart),
            ),
          ],
        ),
        SettingsGroup(
          title: "Game",
          children: [
            SliderSettingsTile(
                title: "minimal gap width",
                settingKey: "min-gap-width",
                defaultValue: _defaultMinGapWidth,
                min: 10,
                max: 150,
                step: 1,
                leading: Icon(Icons.social_distance))
          ],
        )
      ]),
    );
  }
}
