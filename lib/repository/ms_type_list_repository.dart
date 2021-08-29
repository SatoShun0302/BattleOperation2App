import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

class MsTypeListRepository  extends BasicDatabase {
  late Database db;

  void init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    database.then((value) {
      db = value;
    });
  }

  @override
  String get tableName => DatabaseEnv.msTypeTable;

  @override
  createTable(Database db, int version) async {
    db = await database;
    DatabaseUtil.createTable(db, 1);
  }

  /// MSタイプのデータを全件取得する.
  Future<List<Map<String, dynamic>>> getRecord() async {
    db = await database;
    List<Map<String, dynamic>> map = await db.query(DatabaseEnv.msTypeTable,
        where: "is_deleted = 0"
    );
    return map;
  }

  /// アプリ初回インストール時にMSタイプのレコード挿入を行う.
  ///
  /// アップデートで新たなタイプが追加された場合はアプリのアップデートではなく
  /// マスターテーブルへレコードを挿入という形で対応する.
  Future<bool> initInsertRecords() async {
    db = await database;
    await db.transaction((txn) async {
      // id,MSタイプ名,削除フラグ
      await txn.rawInsert(
          'INSERT INTO ${DatabaseEnv
              .msTypeTable} VALUES (?, ?, ?)',
          [
            null,
            EnumUtil.getMobileSuitType(MobileSuitType.Raid),
            0
          ]);
      await txn.rawInsert(
          'INSERT INTO ${DatabaseEnv
              .msTypeTable} VALUES (?, ?, ?)',
          [
            null,
            EnumUtil.getMobileSuitType(MobileSuitType.General),
            0
          ]);
      await txn.rawInsert(
          'INSERT INTO ${DatabaseEnv
              .msTypeTable} VALUES (?, ?, ?)',
          [
            null,
            EnumUtil.getMobileSuitType(MobileSuitType.Support),
            0
          ]);
    });
    return true;
  }
}