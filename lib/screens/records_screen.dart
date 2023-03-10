import 'package:flappy_cavity/services/database_service.dart';
import 'package:flappy_cavity/widgets/record_list_tile.dart';
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
  void initState() {
    _getRecords();
    super.initState();
  }

  Future<void> _getRecords() async {
    List<RecordModel> records = await getRecordsFromDatabase();
    setState(() {
      for (RecordModel record in records) {
        if (!_records.contains(record)) {
          _records.add(record);
          _records.sort((RecordModel r1, RecordModel r2) =>
              r2.barriersPassed - r1.barriersPassed);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("your records")),
      body: _records.isEmpty
          ? const Center(
              child: Text("nothing here yet"),
            )
          : ListView.builder(
              itemCount: _records.length,
              itemBuilder: (context, index) {
                return RecordListTile(_records[index]);
              }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
