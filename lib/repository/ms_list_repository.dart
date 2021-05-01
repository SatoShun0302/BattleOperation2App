import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// MS一覧テーブルに対応するリポジトリー
class MsListRepository extends BasicDatabase {
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
    final String msAssultCsv = await rootBundle.loadString('assets/csv/ms_assult.csv');
    final String msGeneralCsv = await rootBundle.loadString('assets/csv/ms_general.csv');
    final String msSupportCsv = await rootBundle.loadString('assets/csv/ms_support.csv');
    List<MsList> msLists = [];

    // 読み込んだcsvから強襲、汎用、支援のMSリストを生成する
    for (String line in msAssultCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MsList msList = new MsList(
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
          int.parse(rows[11])
      );
      msLists.add(msList);
    }
    for (String line in msGeneralCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MsList msList = new MsList(
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
          int.parse(rows[11])
      );
      msLists.add(msList);
    }
    for (String line in msSupportCsv.split("\r\n")) {
      List rows = line.split(",");
      // 要素0はid、1以降を使用する
      MsList msList = new MsList(
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
          int.parse(rows[11])
      );
      msLists.add(msList);
    }
    return true;
  }
}