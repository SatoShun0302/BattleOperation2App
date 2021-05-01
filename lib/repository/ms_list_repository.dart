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
  String get tableName => DatabaseEnv.stageTable;

  @override
  createTable(Database db, int version) async {
    db = await database;
    DatabaseUtil.createTable(db, 1);
  }

  /// アプリ初回インストール時にレコード挿入を行う.
  /// 強襲、汎用、支援それぞれ別のテーブルにinsertをし、個別に処理結果フラグを持つ.
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
    List<MsList> msRaidLists = [];
    List<MsList> msGeneralLists = [];
    List<MsList> msSupportLists = [];

    // 読み込んだcsvから強襲、汎用、支援のMSリストを生成する
    for (String line in msRaidCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MsList _msList = new MsList(
          rows[1],
          int.parse(rows[2]),
          rows[3],
          int.parse(rows[4]),
          int.parse(rows[5]),
          int.parse(rows[6]),
          rows[7],
          rows[8],
          rows[9],
          int.parse(rows[10]),
          int.parse(rows[11]));
      msRaidLists.add(_msList);
    }
    for (String line in msGeneralCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MsList _msList = new MsList(
          rows[1],
          int.parse(rows[2]),
          rows[3],
          int.parse(rows[4]),
          int.parse(rows[5]),
          int.parse(rows[6]),
          rows[7],
          rows[8],
          rows[9],
          int.parse(rows[10]),
          int.parse(rows[11]));
      msGeneralLists.add(_msList);
    }
    for (String line in msSupportCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MsList _msList = new MsList(
          rows[1],
          int.parse(rows[2]),
          rows[3],
          int.parse(rows[4]),
          int.parse(rows[5]),
          int.parse(rows[6]),
          rows[7],
          rows[8],
          rows[9],
          int.parse(rows[10]),
          int.parse(rows[11]));
      msSupportLists.add(_msList);
    }
    // DBにレコードを挿入する
    List<int> insertResultNum = [];
    await db.transaction((txn) async {
      try {
        await Future.forEach(msRaidLists, (MsList msList) async {
          int _id = await txn.rawInsert(
              'INSERT INTO ${DatabaseEnv.raidMsTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
        _prefs.setBool(SharedPrefKey.SuccessInsertRaidNs.toString(), true);
      } catch (e) {
        print(e);
        _prefs.setBool(SharedPrefKey.SuccessInsertRaidNs.toString(), false);
      }
      try {
        await Future.forEach(msGeneralLists, (MsList msList) async {
          int _id = await txn.rawInsert(
              'INSERT INTO ${DatabaseEnv.generalMsTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
        _prefs.setBool(SharedPrefKey.SuccessInsertGeneralNs.toString(), true);
      } catch (e) {
        _prefs.setBool(SharedPrefKey.SuccessInsertGeneralNs.toString(), false);
      }
      try {
        await Future.forEach(msSupportLists, (MsList msList) async {
          int _id = await txn.rawInsert(
              'INSERT INTO ${DatabaseEnv.supportMsTable} VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
        _prefs.setBool(SharedPrefKey.SuccessInsertSupportNs.toString(), true);
      } catch (e) {
        _prefs.setBool(SharedPrefKey.SuccessInsertSupportNs.toString(), false);
      }
    });
    return true;
  }
}
