import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

class CostListRepository extends BasicDatabase {
  late Database db;

  void init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    database.then((value) {
      db = value;
    });
  }

  @override
  String get tableName => DatabaseEnv.costTable;

  @override
  createTable(Database db, int version) async {
    db = await database;
    DatabaseUtil.createTable(db, 1);
  }

  /// コストのデータを全件取得する.
  Future<List<Map<String, dynamic>>> getRecord() async {
    db = await database;
    List<Map<String, dynamic>> map = await db.query(DatabaseEnv.costTable,
        where: "is_deleted = 0"
    );
    return map;
  }
}