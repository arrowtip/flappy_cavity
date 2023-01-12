import 'package:flappy_cavity/models/record_model.dart';
import 'package:flutter/material.dart';

class RecordListTile extends StatelessWidget {
  const RecordListTile(this._record, {Key? key}) : super(key: key);

  final RecordModel _record;

  @override
  Widget build(BuildContext context) {
    DateTime date = _record.date.toLocal();
    return Card(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("time: ${_record.duration.inSeconds}s"),
          Text("#barriers: ${_record.barriersPassed}"),
          Text("date: ${date.year}-${date.month}-${date.day}")
        ],
      ),
    );
  }
}
