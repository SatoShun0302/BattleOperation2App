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
          int.parse(rows[0]), rows[1], rows[2], rows[3], int.parse(rows[4]));
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
        _prefs.setBool(SharedPrefKey.SuccessInsertRaidNs.toString(), true);
      } catch (e) {
        _prefs.setBool(SharedPrefKey.SuccessInsertRaidNs.toString(), false);
      }
    });
    return true;
  }
}