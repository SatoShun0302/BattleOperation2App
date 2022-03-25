import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// マップテーブルを操作するリポジトリー
class MapListRepository extends BasicDatabase {
  late Database db;

  void init() async {
    database.then((value) {
      db = value;
    });
  }

  @override
  String get tableName => DatabaseEnv.stageTable;

  @override
  createTable(Database db, int version) async {
    db = await database;
    DatabaseUtil.createTable(db, 1);
  }

  /// マップのデータを全件取得する.
  ///
  /// 論理削除されたデータは含まない.
  Future<List<MapList>> getRecord() async {
    db = await database;
    List<Map<String, dynamic>> map = await db.query(DatabaseEnv.stageTable,
        where: "is_deleted = ?",
      whereArgs: [
       0
      ]);
    List<MapList> mapLists = [];
    map.forEach((element) {
      mapLists.add(MapList.fromDynamic(element));
    });
    return mapLists;
  }

  /// アプリ初回インストール時にレコード挿入を行う.
  /// insert処理に成功した場合はtrueを、失敗した場合はfalseを返す
  Future<bool> initInsertRecords() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    db = await database;
    final String mapCsv = await rootBundle.loadString('assets/csv/map.csv');
    List<MapList> mapLists = [];

    // 読み込んだcsvからマップリストを生成する
    for (String line in mapCsv.split("\r\n")) {
      List rows = line.split(",");
      MapList mapList = new MapList(
          null, int.parse(rows[0]), rows[1], rows[2], rows[3], int.parse(rows[4]));
      mapLists.add(mapList);
    }
    // DBにレコードを挿入する
    List<int> insertResultNum = [];
    await db.transaction((txn) async {
      try {
        await Future.forEach(mapLists, (MapList mapList) async {
          int _id = await txn.rawInsert(
              'INSERT INTO ${DatabaseEnv.stageTable} VALUES (?, ?, ?, ?, ?, ?)', [
            mapList.id,
            mapList.mapId,
            mapList.mapName,
            mapList.officialPicUrl,
            mapList.wikiPicUrl,
            mapList.isDeleted
          ]);
          insertResultNum.add(_id);
        });
        _prefs.setBool(SharedPrefKey.InsertedInitMapRecord.toString(), true);
      } catch (e) {
        _prefs.setBool(SharedPrefKey.InsertedInitMapRecord.toString(), false);
      }
    });
    return true;
  }


}
