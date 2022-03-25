import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/entity/cost.dart';

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
  Future<List<Cost>> getRecord() async {
    db = await database;
    List<Map<String, dynamic>> map =
        await db.query(DatabaseEnv.costTable, where: "is_deleted = 0");
    List<Cost> costList = [];
    map.forEach((element) {
      costList.add(Cost.fromDynamic(element));
    });
    return costList;
  }

  /// アプリ初回インストール時にレコード挿入を行う.
  ///
  /// insert処理に成功した場合はtrueを、失敗した場合はfalseを返す.
  Future<bool> initInsertRecords() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    db = await database;
    final String mapCsv = await rootBundle.loadString('assets/csv/cost.csv');
    List<String> rows = [];
    for (String line in mapCsv.split("\r\n")) {
      rows.add(line);
    }
    // DBにレコードを挿入する
    await db.transaction((txn) async {
      try {
        await Future.forEach(rows, (String row) async {
          int _id = await txn.rawInsert(
              'INSERT INTO ${DatabaseEnv.costTable} VALUES (?, ?, ?)',
              [null, int.parse(row), DatabaseEnv.isDeletedFalse]);
        });
        _prefs.setBool(SharedPrefKey.SuccessInsertCost.toString(), true);
      } catch (e) {
        _prefs.setBool(SharedPrefKey.SuccessInsertCost.toString(), false);
      }
    });
    return true;
  }
}
