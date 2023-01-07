import 'package:flappy_cavity/models/record_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  Future<void> insertRecord(RecordModel record) async {}

  Future<List<RecordModel>> getRecords() async {
    return [];
  }
}
