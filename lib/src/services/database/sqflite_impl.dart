import 'package:shortcut_whats/src/models/history_model.dart';
import 'package:shortcut_whats/src/services/database/interface.dart';
import 'package:sqflite/sqflite.dart';

const String TABLE_NAME = "history";

class DataBaseService implements IDataBase {
  static final DataBaseService _dataBaseService = DataBaseService._internal();

  factory DataBaseService() => _dataBaseService;

  DataBaseService._internal();

  Future<Database> init() async {
    return await openDatabase((await getDatabasesPath() + "history.db"),
        version: 1, onCreate: (db, int version) async {
      var sql = "CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY, phone TEXT)";
      await db.execute(sql);
      return db;
    });
  }

  @override
  Future<void> clear() async {
    var db = await init();
    await db.delete(TABLE_NAME);
    await db.close();
  }

  @override
  Future<int> create(String phone) async {
    var db = await init();
    var id = await db.insert(TABLE_NAME, {"phone": phone},
          conflictAlgorithm: ConflictAlgorithm.replace);
    await db.close();
    return id;
  }

  @override
  Future<int> dell(int id) async {
    var db = await init();
    var deletedId = await db.delete(TABLE_NAME, where: "id = ?", whereArgs: [id]);
    await db.close();
    return deletedId;
  }

  @override
  Future<List<HistoryModel>> getHistory() async {
    List<Map<String, dynamic>> query;
    var db = await init();
    query = await db.query(TABLE_NAME);
    await db.close();
    return List.generate(query.length, (index) => HistoryModel.fromJson(query[index]));
  }
}
