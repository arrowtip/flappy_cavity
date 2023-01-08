class RecordModel {
  final Duration _runDuration;
  final DateTime _runDate;
  final int _barriersPassed;

  RecordModel(this._runDuration, this._runDate, this._barriersPassed);

  Duration get duration {
    return _runDuration;
  }

  DateTime get date {
    return _runDate;
  }

  int get barriersPassed {
    return _barriersPassed;
  }

  factory RecordModel.fromMap(Map<String, Object?> map,
      {required String durationKey,
      required String dateKey,
      required String barriersPassedKey}) {
    return RecordModel(
        Duration(seconds: map[durationKey] as int),
        DateTime.fromMillisecondsSinceEpoch(map[dateKey] as int),
        map[barriersPassedKey] as int);
  }
}
