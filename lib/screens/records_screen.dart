import 'package:flutter/material.dart';

import '../models/record_model.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final List<RecordModel> _records = [];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("not yet done"),
    );
  }
}
