import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class EarbudService {
  late FlutterBlue _flutterBlue;
  bool _isConnected = false;
  bool _earConnectFound = false;
  final Duration _updateInterval = const Duration(milliseconds: 1000);
  double _currentBPM = 80;
  double _lastSmoothedBPM = 80;
  double _lastSndSmoothedBPM = 80;
  final double _smoothingAlpha = 0.8;
  double get bpm => _currentBPM;
  bool get isConnected => _isConnected;

  EarbudService() {
    _flutterBlue = FlutterBlue.instance;
  }

  double _calculateHeartRate(List<int> rawData) {
    Uint8List bytes = Uint8List.fromList(rawData);

    // based on GATT standard
    int bpm = bytes[1];
    if (!((bytes[0] & 0x01) == 0)) {
      bpm = (((bpm >> 8) & 0xFF) | ((bpm << 8) & 0xFF00));
    }

    double currentSmoothedBPM =
        _lastSmoothedBPM + _smoothingAlpha * (bpm - _lastSmoothedBPM);
    double currentSndSmoothedBPM = _lastSndSmoothedBPM +
        _smoothingAlpha * (currentSmoothedBPM - _lastSndSmoothedBPM);
    _lastSmoothedBPM = currentSmoothedBPM;
    _lastSndSmoothedBPM = currentSndSmoothedBPM;
    return 2 * currentSmoothedBPM - currentSndSmoothedBPM;
  }

  Future<bool> isBluetoothEnabled() async {
    return await _flutterBlue.isOn;
  }

  Future<bool> isLocationEnabled() async {
    return await Permission.locationWhenInUse.serviceStatus.isEnabled;
  }

  void connect({required Function onConnectStateChange}) {
    // start scanning
    _flutterBlue.startScan(timeout: const Duration(seconds: 8));

    if (!_isConnected) {
      _flutterBlue.connectedDevices.asStream().listen((devices) async {
        for (var device in devices) {
          if (device.name == "earconnect") {
            await device.disconnect();
          }
        }
      });
    }

    // listen to scan results
    _flutterBlue.scanResults.listen((results) async {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name == "earconnect" && !_earConnectFound) {
          _earConnectFound = true;

          await _flutterBlue.stopScan();

          r.device.state.listen((state) {
            // listen for connection state changes
            _isConnected = (state == BluetoothDeviceState.connected);
            onConnectStateChange();
          });

          await r.device.connect();

          List<BluetoothService> services = await r.device.discoverServices();

          for (var service in services) {
            // iterate over services
            for (BluetoothCharacteristic characteristic
                in service.characteristics) {
              // iterate over characteristics
              if (characteristic.uuid.toString() ==
                  "00002a37-0000-1000-8000-00805f9b34fb") {
                characteristic.value.listen((rawData) {
                  if (kDebugMode) {
                    print("heart rate: ${_calculateHeartRate(rawData)}");
                  }
                  _currentBPM = _calculateHeartRate(rawData);
                });
                await characteristic.setNotifyValue(true);
                await Future.delayed(_updateInterval);
                break;
              }
            }
          }
        }
      }
    });
  }
}
