import 'package:flappy_cavity/models/record_model.dart';

import '../main.dart';

class DatabaseService {
  static const String _recordTable = "Records";
  static const String _recordId = "id";
  static const String _recordDuration = "durationSec";
  static const String _recordBarriersPassed = "barriersPassed";

  Future<void> insertRecord(RecordModel record) async {
    await database.rawInsert(
        "insert into $_recordTable ($_recordId, $_recordDuration, $_recordBarriersPassed)"
        "values (?, ?, ?)",
        [record.date, record.duration, record.barriersPassed]);
  }

  Future<List<RecordModel>> getRecords() async {
    List<Map<String, Object?>> mapList = await database.query(_recordTable);
    return mapList
        .map((e) => RecordModel.fromMap(e,
            barriersPassedKey: _recordBarriersPassed,
            durationKey: _recordDuration,
            dateKey: _recordId))
        .toList();
  }
}
