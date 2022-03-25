import 'package:battle_operation2_app/config/battle_record_env.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// MS一覧テーブルに対応するリポジトリー
class MsListRepository extends BasicDatabase {
  late Database db;

  void init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    database.then((value) {
      db = value;
    });
  }

  @override
  String get tableName => DatabaseEnv.msListTable;

  @override
  createTable(Database db, int version) async {
    db = await database;
    DatabaseUtil.createTable(db, 1);
  }

  /// MSのデータを全件取得する.
  ///
  /// 機体名での重複を省く.
  /// 論理削除されたデータは含まない.
  Future<List<MobileSuit>> getRecord() async {
    db = await database;
    List<MobileSuit> _msList = [];
    List<Map<String, dynamic>> records = await db.query(DatabaseEnv.msListTable,
        distinct: true,
        where: "is_deleted = 0"
    );
    records.forEach((element) {
      _msList.add(MobileSuit.fromDynamic(element));
    });
    return _msList;
  }

  /// 選択されたマップとコストに対応したMSのデータを全件取得する.
  ///
  /// 論理削除されたデータは含まない.
  Future<List<MobileSuit>> getRecordFindByMapAndCost({int mapId = 0, int cost = 0}) async {
    db = await database;
    List<MobileSuit> _msList = [];
    String _where = "";
    // 選択されたマップが地上か宇宙かによってwhere句を変える
    if (BattleRecordEnv.groundMapIdMin <= mapId && mapId <= BattleRecordEnv.groundMapIdMax) {
      _where = "is_deleted = 0 AND cost = ? AND can_ground = 1";
    } else if (BattleRecordEnv.spaceMapIdMin <= mapId && mapId <= BattleRecordEnv.spaceMapIdMax) {
      _where = "is_deleted = 0 AND cost = ? AND can_space = 1";
    }
    List<Map<String, dynamic>> records = await db.query(DatabaseEnv.msListTable,
        where: _where,
        whereArgs: [cost]
    );
    records.forEach((element) {
      _msList.add(MobileSuit.fromDynamic(element));
    });
    return _msList;
  }

  Future<bool> insertRecords(List<MobileSuit> msList) async {
    db = await database;
    // DBにレコードを挿入する
    List<int> insertResultNum = [];
    await db.transaction((txn) async {
      try {
        await Future.forEach(msList, (MobileSuit msList) async {
          int _id = await txn.rawInsert(
              'INSERT INTO ${DatabaseEnv.msListTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
              [
                msList.id,
                msList.msName,
                msList.msLevel,
                msList.msType,
                msList.canGround,
                msList.canSpace,
                msList.cost,
                msList.officialPicUrl,
                msList.wikiPicUrl,
                msList.wikiPageUrl,
                msList.isFavorite,
                msList.isDeleted
              ]);
          insertResultNum.add(_id);
        });
      } catch (e) {
        print(e);
        return false;
      }
    });
    return true;
  }

  /// 選択されたマップとコストに対応したMSのデータを全件取得する.
  ///
  /// 論理削除されたデータは含まない.
  // Future<List<MobileSuit>> getRecordFindByMapAndCost({int mapId = 0, int cost = 0}) async {
  //   db = await database;
  //   List<MobileSuit> _msList = [];
  //   String _where = "";
  //   // 選択されたマップが地上か宇宙かによってwhere句を変える
  //   if (BattleRecordEnv.groundMapIdMin <= mapId && mapId <= BattleRecordEnv.groundMapIdMax) {
  //     _where = "is_deleted = 0 AND cost = ? AND can_ground = 1";
  //   } else if (BattleRecordEnv.spaceMapIdMin <= mapId && mapId <= BattleRecordEnv.spaceMapIdMax) {
  //     _where = "is_deleted = 0 AND cost = ? AND can_space = 1";
  //   }
  //   // 汎用機
  //   List<Map<String, dynamic>> generalMsList = await db.query(DatabaseEnv.generalMsTable,
  //       where: _where,
  //       whereArgs: [cost]
  //   );
  //   generalMsList.forEach((element) {
  //     _msList.add(MobileSuit.fromDynamic(element));
  //   });
  //   // 強襲機
  //   List<Map<String, dynamic>> raidMsList = await db.query(DatabaseEnv.raidMsTable,
  //       where: _where,
  //       whereArgs: [cost]
  //   );
  //   raidMsList.forEach((element) {
  //     _msList.add(MobileSuit.fromDynamic(element));
  //   });
  //   // 支援機
  //   List<Map<String, dynamic>> supportMsList = await db.query(DatabaseEnv.supportMsTable,
  //       where: _where,
  //       whereArgs: [cost]
  //   );
  //   supportMsList.forEach((element) {
  //     _msList.add(MobileSuit.fromDynamic(element));
  //   });
  //   return _msList;
  // }

  /// アプリ初回インストール時にレコード挿入を行う.
  /// 強襲、汎用、支援それぞれを同一テーブルにinsertをし、処理結果フラグを返す.
  /// 全てのinsert処理に成功した場合はtrueを、失敗した場合はfalseを返す.
  Future<bool> initInsertRecords() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    db = await database;
    final String msRaidCsv =
    await rootBundle.loadString('assets/csv/ms_raid.csv');
    final String msGeneralCsv =
    await rootBundle.loadString('assets/csv/ms_general.csv');
    final String msSupportCsv =
    await rootBundle.loadString('assets/csv/ms_support.csv');
    List<MobileSuit> msLists = [];
    List<MobileSuit> msRaidLists = [];
    List<MobileSuit> msGeneralLists = [];
    List<MobileSuit> msSupportLists = [];

    // 読み込んだcsvから強襲、汎用、支援のMSリストを生成する
    for (String line in msRaidCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MobileSuit _msList = new MobileSuit(
          null,
          rows[1],
          int.parse(rows[2]),
          int.parse(rows[3]),
          int.parse(rows[4]),
          int.parse(rows[5]),
          int.parse(rows[6]),
          rows[7],
          rows[8],
          rows[9],
          int.parse(rows[10]),
          int.parse(rows[11]));
      msLists.add(_msList);
    }
    for (String line in msGeneralCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MobileSuit _msList = new MobileSuit(
          null,
          rows[1],
          int.parse(rows[2]),
          int.parse(rows[3]),
          int.parse(rows[4]),
          int.parse(rows[5]),
          int.parse(rows[6]),
          rows[7],
          rows[8],
          rows[9],
          int.parse(rows[10]),
          int.parse(rows[11]));
      msLists.add(_msList);
    }
    for (String line in msSupportCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MobileSuit _msList = new MobileSuit(
          null,
          rows[1],
          int.parse(rows[2]),
          int.parse(rows[3]),
          int.parse(rows[4]),
          int.parse(rows[5]),
          int.parse(rows[6]),
          rows[7],
          rows[8],
          rows[9],
          int.parse(rows[10]),
          int.parse(rows[11]));
      msLists.add(_msList);
    }
    // DBにレコードを挿入する
    List<int> insertResultNum = [];
    await db.transaction((txn) async {
      try {
        await Future.forEach(msLists, (MobileSuit msList) async {
          int _id = await txn.rawInsert(
              'INSERT INTO ${DatabaseEnv.msListTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
              [
                msList.id,
                msList.msName,
                msList.msLevel,
                msList.msType,
                msList.canGround,
                msList.canSpace,
                msList.cost,
                msList.officialPicUrl,
                msList.wikiPicUrl,
                msList.wikiPageUrl,
                msList.isFavorite,
                msList.isDeleted
              ]);
          insertResultNum.add(_id);
        });
        _prefs.setBool(SharedPrefKey.SuccessInsertRaidMs.toString(), true);
      } catch (e) {
        print(e);
        _prefs.setBool(SharedPrefKey.SuccessInsertRaidMs.toString(), false);
      }
    });
    return true;
  }

  /// アプリ初回インストール時にレコード挿入を行う.
  /// 強襲、汎用、支援それぞれ別のテーブルにinsertをし、個別に処理結果フラグを持つ.
  /// 全てのinsert処理に成功した場合はtrueを、失敗した場合はfalseを返す.
  // Future<bool> initInsertRecords() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   db = await database;
  //   final String msRaidCsv =
  //       await rootBundle.loadString('assets/csv/ms_raid.csv');
  //   final String msGeneralCsv =
  //       await rootBundle.loadString('assets/csv/ms_general.csv');
  //   final String msSupportCsv =
  //       await rootBundle.loadString('assets/csv/ms_support.csv');
  //   List<MobileSuit> msRaidLists = [];
  //   List<MobileSuit> msGeneralLists = [];
  //   List<MobileSuit> msSupportLists = [];
  //
  //   // 読み込んだcsvから強襲、汎用、支援のMSリストを生成する
  //   for (String line in msRaidCsv.split("\r\n")) {
  //     List rows = line.split(",");
  //     // 要素0はid、1以降を使用する
  //     MobileSuit _msList = new MobileSuit(
  //         null,
  //         rows[1],
  //         int.parse(rows[2]),
  //         rows[3],
  //         int.parse(rows[4]),
  //         int.parse(rows[5]),
  //         int.parse(rows[6]),
  //         rows[7],
  //         rows[8],
  //         rows[9],
  //         int.parse(rows[10]),
  //         int.parse(rows[11]));
  //     msRaidLists.add(_msList);
  //   }
  //   for (String line in msGeneralCsv.split("\r\n")) {
  //     List rows = line.split(",");
  //     // 要素0はid、1以降を使用する
  //     MobileSuit _msList = new MobileSuit(
  //         null,
  //         rows[1],
  //         int.parse(rows[2]),
  //         rows[3],
  //         int.parse(rows[4]),
  //         int.parse(rows[5]),
  //         int.parse(rows[6]),
  //         rows[7],
  //         rows[8],
  //         rows[9],
  //         int.parse(rows[10]),
  //         int.parse(rows[11]));
  //     msGeneralLists.add(_msList);
  //   }
  //   for (String line in msSupportCsv.split("\r\n")) {
  //     List rows = line.split(",");
  //     // 要素0はid、1以降を使用する
  //     MobileSuit _msList = new MobileSuit(
  //         null,
  //         rows[1],
  //         int.parse(rows[2]),
  //         rows[3],
  //         int.parse(rows[4]),
  //         int.parse(rows[5]),
  //         int.parse(rows[6]),
  //         rows[7],
  //         rows[8],
  //         rows[9],
  //         int.parse(rows[10]),
  //         int.parse(rows[11]));
  //     msSupportLists.add(_msList);
  //   }
  //   // DBにレコードを挿入する
  //   List<int> insertResultNum = [];
  //   await db.transaction((txn) async {
  //     try {
  //       // 強襲機
  //       await Future.forEach(msRaidLists, (MobileSuit msList) async {
  //         int _id = await txn.rawInsert(
  //             'INSERT INTO ${DatabaseEnv.raidMsTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
  //             [
  //               msList.id,
  //               msList.msName,
  //               msList.msLevel,
  //               msList.msType,
  //               msList.canGround,
  //               msList.canSpace,
  //               msList.cost,
  //               msList.officialPicUrl,
  //               msList.wikiPicUrl,
  //               msList.wikiPageUrl,
  //               msList.isFavorite,
  //               msList.isDeleted
  //             ]);
  //         insertResultNum.add(_id);
  //       });
  //       _prefs.setBool(SharedPrefKey.SuccessInsertRaidMs.toString(), true);
  //     } catch (e) {
  //       print(e);
  //       _prefs.setBool(SharedPrefKey.SuccessInsertRaidMs.toString(), false);
  //     }
  //     try {
  //       // 汎用機
  //       await Future.forEach(msGeneralLists, (MobileSuit msList) async {
  //         int _id = await txn.rawInsert(
  //             'INSERT INTO ${DatabaseEnv.generalMsTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
  //             [
  //               msList.id,
  //               msList.msName,
  //               msList.msLevel,
  //               msList.msType,
  //               msList.canGround,
  //               msList.canSpace,
  //               msList.cost,
  //               msList.officialPicUrl,
  //               msList.wikiPicUrl,
  //               msList.wikiPageUrl,
  //               msList.isFavorite,
  //               msList.isDeleted
  //             ]);
  //         insertResultNum.add(_id);
  //       });
  //       _prefs.setBool(SharedPrefKey.SuccessInsertGeneralMs.toString(), true);
  //     } catch (e) {
  //       _prefs.setBool(SharedPrefKey.SuccessInsertGeneralMs.toString(), false);
  //     }
  //     try {
  //       // 支援機
  //       await Future.forEach(msSupportLists, (MobileSuit msList) async {
  //         int _id = await txn.rawInsert(
  //             'INSERT INTO ${DatabaseEnv.supportMsTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
  //             [
  //               msList.id,
  //               msList.msName,
  //               msList.msLevel,
  //               msList.msType,
  //               msList.canGround,
  //               msList.canSpace,
  //               msList.cost,
  //               msList.officialPicUrl,
  //               msList.wikiPicUrl,
  //               msList.wikiPageUrl,
  //               msList.isFavorite,
  //               msList.isDeleted
  //             ]);
  //         insertResultNum.add(_id);
  //       });
  //       _prefs.setBool(SharedPrefKey.SuccessInsertSupportMs.toString(), true);
  //     } catch (e) {
  //       _prefs.setBool(SharedPrefKey.SuccessInsertSupportMs.toString(), false);
  //     }
  //   });
  //   return true;
  // }
}
