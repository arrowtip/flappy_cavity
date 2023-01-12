import 'package:flappy_cavity/models/record_model.dart';
import 'package:flutter/material.dart';

class RecordListTile extends StatelessWidget {
  const RecordListTile(this._record, {Key? key}) : super(key: key);

  final RecordModel _record;

  @override
  Widget build(BuildContext context) {
    DateTime date = _record.date.toLocal();
    TextStyle style = const TextStyle(fontSize: 18);
    return Card(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("time: ${_record.duration.inSeconds}s", style: style),
          Text("#barriers: ${_record.barriersPassed}", style: style),
          Text("date: ${date.year}-${date.month}-${date.day}", style: style)
        ],
      ),
    );
  }
}
